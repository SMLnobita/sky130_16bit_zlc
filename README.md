# SKY130 16-bit Zero Leading Counter

## 1. Giới thiệu

Project này thiết kế một mạch **16-bit Zero Leading Counter (ZLC)** trên công nghệ **SkyWater SKY130**. Mạch nhận đầu vào `A[15:0]` và trả về `Y[4:0]`, trong đó `Y` là số bit `0` liên tiếp tính từ bit có trọng số cao nhất của `A`.

Ví dụ:

| Input `A[15:0]` | Output `Y[4:0]` | Ý nghĩa |
| --- | --- | --- |
| `1xxx_xxxx_xxxx_xxxx` | `00000` | Không có leading zero |
| `01xx_xxxx_xxxx_xxxx` | `00001` | Có 1 leading zero |
| `0000_0000_0000_0001` | `01111` | Có 15 leading zero |
| `0000_0000_0000_0000` | `10000` | Có 16 leading zero |

Mục tiêu của project là hiện thực một mạch tổ hợp nhỏ theo flow thủ công dùng standard cell SKY130: vẽ schematic, xuất Verilog/SPICE netlist, mô phỏng logic, phân tích timing, layout thủ công, LVS và mô phỏng post-layout với RC extraction.

## 2. Chức năng của mạch

Zero Leading Counter đếm số lượng bit `0` đứng trước bit `1` đầu tiên khi quét từ `A[15]` xuống `A[0]`.

Nếu `A` khác `0`, output nằm trong khoảng `0` đến `15`. Nếu toàn bộ input bằng `0`, output bằng `16`.

Mạch có các port chính:

| Port | Hướng | Mô tả |
| --- | --- | --- |
| `A[15:0]` | Input | Dữ liệu 16 bit cần đếm leading zero |
| `Y[4:0]` | Output | Số lượng leading zero |
| `VDD` | Input | Nguồn cấp |
| `GND` | Input | Ground |

## 3. Kiến trúc thiết kế

Thiết kế được xây dựng theo kiến trúc phân cấp:

```text
zlc16
├── zlc8  (A[15:8])
│   ├── zlc4
│   │   ├── zlc2
│   │   └── zlc2
│   └── zlc4
│       ├── zlc2
│       └── zlc2
└── zlc8  (A[7:0])
    ├── zlc4
    │   ├── zlc2
    │   └── zlc2
    └── zlc4
        ├── zlc2
        └── zlc2
```

### `zlc2`

`zlc2` là block cơ bản cho nhóm 2 bit, gồm hai input `HI`, `LO` và hai output `V`, `P`.

- `V = HI | LO`: cho biết nhóm 2 bit có ít nhất một bit `1`.
- `P = ~HI`: nếu nhóm hợp lệ (`V = 1`), `P` cho biết bit `1` đầu tiên nằm ở `HI` hay `LO`.

### `zlc4`

`zlc4` ghép hai block `zlc2`: một block xử lý hai bit cao `A[3:2]`, một block xử lý hai bit thấp `A[1:0]`.

Output `V` cho biết toàn bộ nhóm 4 bit có chứa bit `1`. Output `P[1:0]` mã hóa số leading zero trong nhóm 4 bit khi `V = 1`.

### `zlc8`

`zlc8` ghép hai block `zlc4`. Mạch dùng tín hiệu valid của nửa cao để quyết định chọn kết quả từ nửa cao hay nửa thấp bằng multiplexer.

Output gồm:

- `V`: nhóm 8 bit có ít nhất một bit `1`.
- `P[2:0]`: số leading zero trong nhóm 8 bit khi `V = 1`.

### `zlc16`

`zlc16` ghép hai block `zlc8` cho `A[15:8]` và `A[7:0]`. Tầng cuối chọn kết quả từ nửa cao nếu nửa cao có bit `1`; nếu không thì chọn kết quả từ nửa thấp và cộng thêm offset thông qua bit cao của output.

Output `Y[4]` được dùng để biểu diễn trường hợp đặc biệt `A = 0`. Khi toàn bộ 16 bit đều bằng `0`, `Y[4] = 1` và `Y[3:0] = 0`, tức `Y = 16`.

## 4. Standard cell sử dụng

Thiết kế dùng các standard cell từ thư viện `sky130_fd_sc_hd`, chủ yếu gồm:

| Cell | Vai trò |
| --- | --- |
| `sky130_fd_sc_hd__or2_1` | Tạo tín hiệu valid cho từng nhóm bit |
| `sky130_fd_sc_hd__inv_1` | Đảo tín hiệu valid hoặc bit chọn |
| `sky130_fd_sc_hd__mux2_1` | Chọn kết quả giữa nửa cao và nửa thấp |
| `sky130_fd_sc_hd__and2_1` | Mask output khi input toàn zero |
| `sky130_fd_sc_hd__tapvpwrvgnd_1` | Tap cell cho layout |

Tính theo phân cấp logic, `zlc16` gồm 46 instance standard cell logic, chưa tính tap cell trong layout.

## 5. Cấu trúc thư mục

```text
sky130_ZLC_16/
├── xschem/
│   ├── zlc2.sch, zlc2.sym, zlc2.v, zlc2.spice
│   ├── zlc4.sch, zlc4.sym, zlc4.v, zlc4.spice
│   ├── zlc8.sch, zlc8.sym, zlc8.v, zlc8.spice
│   └── zlc16.sch, zlc16.sym, zlc16.v, zlc16.spice
├── iverilog/
│   ├── zlc2_tb.v, zlc4_tb.v, zlc8_tb.v, zlc16_tb.v
│   ├── zlc2.vcd, zlc4.vcd, zlc8.vcd, zlc16.vcd
│   └── iverilog_2.log, iverilog_4.log, iverilog_8.log, iverilog_16.log
├── opensta/
│   ├── zlc16.tcl
│   └── zlc16.log
├── magic/
│   ├── zlc2.mag, zlc4.mag, zlc8.mag, zlc16.mag
│   ├── zlc2.spice, zlc4.spice, zlc8.spice, zlc16.spice
│   └── zlc2.rcx.spice, zlc4.rcx.spice, zlc8.rcx.spice, zlc16.rcx.spice
├── netgen/
│   ├── lvs
│   └── zlc2.log, zlc4.log, zlc8.log, zlc16.log
└── ngspice/
    ├── zlc16_tb.spice
    ├── zlc16.rcx.raw
    └── zlc16_ngspice.log
```

## 6. Schematic và netlist

Các schematic được vẽ theo thứ tự từ block nhỏ đến block lớn:

1. `zlc2`: block nền tảng cho nhóm 2 bit.
2. `zlc4`: ghép hai `zlc2`.
3. `zlc8`: ghép hai `zlc4`.
4. `zlc16`: ghép hai `zlc8` và thêm logic tạo output `Y[4:0]`.

Mỗi block trong thư mục `xschem/` có đủ file schematic (`.sch`), symbol (`.sym`), Verilog netlist (`.v`) và SPICE netlist (`.spice`).

## 7. Functional verification

Functional simulation được kiểm tra bằng các testbench trong thư mục `iverilog/`.

Từ thư mục project `sky130_ZLC_16`, có thể chạy lại các testbench bằng script `iverilog/run`:

```bash
$ cd iverilog
$ ./run zlc2_tb
$ mv iverilog.log iverilog_2.log

$ ./run zlc4_tb
$ mv iverilog.log iverilog_4.log

$ ./run zlc8_tb
$ mv iverilog.log iverilog_8.log

$ ./run zlc16_tb
$ mv iverilog.log iverilog_16.log
```

Sau khi chạy, các file waveform `zlc2.vcd`, `zlc4.vcd`, `zlc8.vcd` và `zlc16.vcd` sẽ được tạo trong thư mục `iverilog/`.

| Module | Số testcase | Kết quả |
| --- | ---: | --- |
| `zlc2` | 4 | Passed |
| `zlc4` | 16 | Passed |
| `zlc8` | 256 | Passed |
| `zlc16` | 65,536 | Passed |

Testbench `zlc16_tb.v` quét toàn bộ không gian input 16 bit. Log ghi nhận:

```text
TEST PASSED: zlc16 all 65536 cases successful!
```

Các waveform `.vcd` cũng đã được tạo cho từng module để phục vụ việc quan sát tín hiệu.

## 8. Static Timing Analysis

Timing của `zlc16` được phân tích với clock ảo 10 ns. Kết quả trong `opensta/zlc16.log` cho thấy mạch đạt timing theo constraint đã đặt.

Chạy OpenSTA cho top module `zlc16`:

```bash
$ cd ../opensta
$ sta zlc16.tcl | tee zlc16.log
```

| Hạng mục | Kết quả |
| --- | --- |
| Max path | `A[3]` đến `Y[0]` |
| Data arrival time max path | 1.31 ns |
| Slack max path | 8.49 ns |
| Min path | `A[0]` đến `Y[4]` |
| Data arrival time min path | 0.42 ns |
| Slack min path | 0.40 ns |
| TNS max | 0.00 |
| WNS max | 0.00 |

Ước lượng công suất từ OpenSTA:

| Thành phần | Công suất |
| --- | ---: |
| Internal power | 3.52 uW |
| Switching power | 2.19 uW |
| Leakage power | 0.195 nW |
| Total power | 5.71 uW |

## 9. Layout và extraction

Layout được tạo trong Magic theo cùng cấu trúc phân cấp với schematic:

- `zlc2.mag`
- `zlc4.mag`
- `zlc8.mag`
- `zlc16.mag`

Từ các layout này, project đã có hai loại SPICE netlist trong thư mục `magic/`:

- Netlist LVS: `zlc*.spice`
- Netlist có parasitic RC extraction: `zlc*.rcx.spice`

Nếu cần xuất lại netlist từ layout Magic, chạy:

```bash
$ cd ../magic
$ ./netlist zlc2
$ ./netlist zlc4
$ ./netlist zlc8
$ ./netlist zlc16
```

Layout `zlc16` dùng các block `zlc8` có sẵn, kết hợp thêm các cell logic ở tầng top để tạo output cuối cùng. Các port `A[15:0]`, `Y[4:0]`, `VDD` và `GND` đã được gán label trong file Magic.

## 10. LVS verification

LVS được kiểm tra bằng Netgen giữa SPICE netlist từ schematic và SPICE netlist trích xuất từ layout.

Chạy LVS cho từng cấp thiết kế:

```bash
$ cd ../netgen
$ ./lvs zlc2
$ ./lvs zlc4
$ ./lvs zlc8
$ ./lvs zlc16
```

| Module | Kết quả LVS |
| --- | --- |
| `zlc2` | Circuits match uniquely |
| `zlc4` | Circuits match uniquely |
| `zlc8` | Circuits match uniquely |
| `zlc16` | Circuits match uniquely |

Kết quả cuối trong `netgen/zlc16.log`:

```text
Final result: Circuits match uniquely!
```

Điều này xác nhận layout của `zlc16` khớp với schematic về mặt kết nối điện.

## 11. Post-layout simulation

Post-layout simulation được thực hiện với netlist `magic/zlc16.rcx.spice`, tức netlist đã có parasitic resistance/capacitance sau layout extraction.

Testbench `ngspice/zlc16_tb.spice` tập trung quan sát đường lan truyền từ `A[3]` đến `Y[0]`, là đường dài được ghi nhận trong phân tích timing.

Chạy mô phỏng post-layout bằng Ngspice:

```bash
$ cd ../ngspice
$ ngspice -b -r zlc16.rcx.raw zlc16_tb.spice | tee zlc16_ngspice.log
```

Sau khi chạy xong, waveform post-layout sẽ được lưu trong file `zlc16.rcx.raw`.

Kết quả mô phỏng trong `ngspice/zlc16_ngspice.log`:

| Hạng mục | Giá trị |
| --- | ---: |
| Số cột dữ liệu | 8 |
| Số dòng dữ liệu | 20,020 |
| Thời gian mô phỏng transient | 20 ns |
| Total analysis time | 164.119 s |
| Total elapsed time | 201.894 s |

Waveform post-layout được lưu tại `ngspice/zlc16.rcx.raw`.

## 12. Tổng kết

Project `sky130_ZLC_16` đã hoàn thành một mạch Zero Leading Counter 16 bit theo flow thủ công trên SKY130:

- Schematic phân cấp từ `zlc2` đến `zlc16`.
- Verilog/SPICE netlist được xuất từ schematic.
- Functional simulation pass toàn bộ 65,536 input của `zlc16`.
- STA đạt timing với constraint clock ảo 10 ns.
- Layout Magic có extraction netlist và RC parasitic netlist.
- LVS pass cho tất cả các cấp `zlc2`, `zlc4`, `zlc8`, `zlc16`.
- Post-layout simulation đã được thực hiện trên extracted RC netlist.
