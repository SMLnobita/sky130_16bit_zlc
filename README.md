# SKY130 16-bit Zero Leading Counter

Project này hiện thực mạch tổ hợp **16-bit Zero Leading Counter (ZLC)** trên công nghệ **SkyWater SKY130** bằng flow thủ công: vẽ schematic, xuất Verilog/SPICE netlist, mô phỏng logic, phân tích timing, layout trong Magic, chạy LVS bằng Netgen và mô phỏng post-layout với RC extraction bằng Ngspice.

Mạch nhận input `A[15:0]` và trả về `Y[4:0]`, trong đó `Y` là số bit `0` liên tiếp tính từ bit MSB `A[15]` xuống đến bit `1` đầu tiên. Nếu `A = 0`, output là `16`.

| Input `A[15:0]` | Output `Y[4:0]` | Ý nghĩa |
| --- | --- | --- |
| `1xxx_xxxx_xxxx_xxxx` | `00000` | Không có leading zero |
| `01xx_xxxx_xxxx_xxxx` | `00001` | Có 1 leading zero |
| `0000_0000_0000_0001` | `01111` | Có 15 leading zero |
| `0000_0000_0000_0000` | `10000` | Có 16 leading zero |

## Trạng thái hiện tại

| Hạng mục | Trạng thái |
| --- | --- |
| Schematic Xschem | Có đủ `zlc2`, `zlc4`, `zlc8`, `zlc16` |
| Verilog/SPICE netlist từ schematic | Đã xuất trong `xschem/` |
| Functional simulation | Pass cho `zlc2`, `zlc4`, `zlc8`, `zlc16` |
| Full input sweep `zlc16` | Pass toàn bộ 65,536 testcase |
| Static Timing Analysis | Pass constraint clock ảo 10 ns |
| Layout Magic | Có layout phân cấp cho `zlc2`, `zlc4`, `zlc8`, `zlc16` |
| RC extraction | Có `zlc*.rcx.spice` trong `magic/` |
| LVS Netgen | Pass cho tất cả các cấp |
| Post-layout simulation | Đã chạy với `magic/zlc16.rcx.spice` |

## Chức năng và port

Zero Leading Counter đếm số lượng bit `0` đứng trước bit `1` đầu tiên khi quét từ MSB xuống LSB.

| Port | Hướng | Mô tả |
| --- | --- | --- |
| `A[15:0]` | Input | Dữ liệu 16 bit cần đếm leading zero |
| `Y[4:0]` | Output | Kết quả trong khoảng `0` đến `16` |
| `VDD` | Input | Nguồn cấp |
| `GND` | Input | Ground |

## Kiến trúc thiết kế

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

`zlc2` là block cơ bản cho nhóm 2 bit, gồm input `HI`, `LO` và output `V`, `P`.

- `V = HI | LO`: nhóm 2 bit có ít nhất một bit `1`.
- `P = ~HI`: khi `V = 1`, `P` cho biết bit `1` đầu tiên nằm ở `HI` hay `LO`.

### `zlc4`

`zlc4` ghép hai block `zlc2`: một block xử lý hai bit cao `A[3:2]`, một block xử lý hai bit thấp `A[1:0]`.

- `V`: nhóm 4 bit có chứa ít nhất một bit `1`.
- `P[1:0]`: số leading zero trong nhóm 4 bit khi `V = 1`.

### `zlc8`

`zlc8` ghép hai block `zlc4`. Tín hiệu valid của nửa cao quyết định chọn kết quả từ nửa cao hay nửa thấp.

- `V`: nhóm 8 bit có chứa ít nhất một bit `1`.
- `P[2:0]`: số leading zero trong nhóm 8 bit khi `V = 1`.

### `zlc16`

`zlc16` ghép hai block `zlc8` cho `A[15:8]` và `A[7:0]`. Tầng cuối chọn kết quả của nửa cao nếu nửa cao có bit `1`; nếu không thì chọn nửa thấp và tạo offset bằng bit cao của output.

`Y[4]` biểu diễn trường hợp đặc biệt `A = 0`. Khi toàn bộ input bằng `0`, `Y[4] = 1` và `Y[3:0] = 0`, tức `Y = 16`.

## Standard cell sử dụng

Thiết kế dùng các standard cell từ thư viện `sky130_fd_sc_hd`:

| Cell | Vai trò |
| --- | --- |
| `sky130_fd_sc_hd__or2_1` | Tạo tín hiệu valid cho từng nhóm bit |
| `sky130_fd_sc_hd__inv_1` | Đảo tín hiệu valid hoặc bit chọn |
| `sky130_fd_sc_hd__mux2_1` | Chọn kết quả giữa nửa cao và nửa thấp |
| `sky130_fd_sc_hd__and2_1` | Mask output khi input toàn zero |
| `sky130_fd_sc_hd__tapvpwrvgnd_1` | Tap cell trong layout |

Tính theo phân cấp logic, `zlc16` gồm 46 instance standard cell logic, chưa tính tap cell trong layout.

## Cấu trúc thư mục

```text
sky130_16bit_zlc/
├── xschem/
│   ├── zlc2.sch, zlc2.sym, zlc2.v, zlc2.spice
│   ├── zlc4.sch, zlc4.sym, zlc4.v, zlc4.spice
│   ├── zlc8.sch, zlc8.sym, zlc8.v, zlc8.spice
│   ├── zlc16.sch, zlc16.sym, zlc16.v, zlc16.spice
│   ├── netlist
│   └── xschemrc
├── iverilog/
│   ├── run
│   ├── zlc2_tb.v, zlc4_tb.v, zlc8_tb.v, zlc16_tb.v
│   ├── zlc2.vcd, zlc4.vcd, zlc8.vcd, zlc16.vcd
│   └── iverilog_2.log, iverilog_4.log, iverilog_8.log, iverilog_16.log
├── opensta/
│   ├── zlc16.tcl
│   └── zlc16.log
├── magic/
│   ├── netlist
│   ├── zlc2.mag, zlc4.mag, zlc8.mag, zlc16.mag
│   ├── zlc2.spice, zlc4.spice, zlc8.spice, zlc16.spice
│   └── zlc2.rcx.spice, zlc4.rcx.spice, zlc8.rcx.spice, zlc16.rcx.spice
├── netgen/
│   ├── lvs
│   └── zlc2.log, zlc4.log, zlc8.log, zlc16.log
├── ngspice/
│   ├── zlc16_tb.spice
│   ├── zlc16.rcx.raw
│   └── zlc16_ngspice.log
└── README.md
```

## Yêu cầu môi trường

Các script giả định môi trường SKY130 đã được cấu hình sẵn:

- `PDK_ROOT` trỏ đến thư mục chứa PDK.
- `PDK` thường là `sky130A`.
- Có các tool: `iverilog`, `vvp`, `opensta` hoặc `sta`, `magic`, `netgen`, `ngspice`.

## Schematic và netlist

Các schematic được vẽ theo thứ tự từ block nhỏ đến block lớn:

1. `zlc2`: block nền tảng cho nhóm 2 bit.
2. `zlc4`: ghép hai `zlc2`.
3. `zlc8`: ghép hai `zlc4`.
4. `zlc16`: ghép hai `zlc8` và thêm logic tạo output `Y[4:0]`.

Mỗi block trong `xschem/` có đủ schematic (`.sch`), symbol (`.sym`), Verilog netlist (`.v`) và SPICE netlist (`.spice`).

## Functional verification

Functional simulation được kiểm tra bằng các testbench trong `iverilog/`. Có thể chạy lại từng testbench bằng script `iverilog/run`:

```bash
cd iverilog

./run zlc2_tb
mv iverilog.log iverilog_2.log

./run zlc4_tb
mv iverilog.log iverilog_4.log

./run zlc8_tb
mv iverilog.log iverilog_8.log

./run zlc16_tb
mv iverilog.log iverilog_16.log
```

Sau khi chạy, waveform `.vcd` được tạo trong `iverilog/`.

| Module | Số testcase | Log | Kết quả |
| --- | ---: | --- | --- |
| `zlc2` | 4 | `iverilog/iverilog_2.log` | Passed |
| `zlc4` | 16 | `iverilog/iverilog_4.log` | Passed |
| `zlc8` | 256 | `iverilog/iverilog_8.log` | Passed |
| `zlc16` | 65,536 | `iverilog/iverilog_16.log` | Passed |

Log của `zlc16` ghi nhận:

```text
TEST PASSED: zlc16 all 65536 cases successful!
```

## Static Timing Analysis

Timing của `zlc16` được phân tích bằng OpenSTA với clock ảo 10 ns, input delay `0 ns`, output delay max `0.2 ns`, output delay min `-0.02 ns`, input driving cell `sky130_fd_sc_hd__inv_2` và output load `0.01 pF`.

Chạy lại STA:

```bash
cd opensta
sta zlc16.tcl | tee zlc16.log
```

Kết quả trong `opensta/zlc16.log`:

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

## Layout và extraction

Layout được tạo trong Magic theo cùng cấu trúc phân cấp với schematic:

- `magic/zlc2.mag`
- `magic/zlc4.mag`
- `magic/zlc8.mag`
- `magic/zlc16.mag`

Project có hai nhóm SPICE netlist từ layout:

- Netlist phục vụ LVS: `magic/zlc*.spice`
- Netlist đã có parasitic RC extraction: `magic/zlc*.rcx.spice`

Xuất lại netlist từ layout:

```bash
cd magic

./netlist zlc2
./netlist zlc4
./netlist zlc8
./netlist zlc16
```

Layout `zlc16` dùng các block `zlc8` có sẵn, kết hợp thêm logic tầng top để tạo output cuối cùng. Các port `A[15:0]`, `Y[4:0]`, `VDD` và `GND` đã được gán label trong file Magic.

## LVS verification

LVS được kiểm tra bằng Netgen giữa SPICE netlist từ schematic và SPICE netlist trích xuất từ layout.

Chạy lại LVS:

```bash
cd netgen

./lvs zlc2
./lvs zlc4
./lvs zlc8
./lvs zlc16
```

| Module | Log | Kết quả LVS |
| --- | --- | --- |
| `zlc2` | `netgen/zlc2.log` | Circuits match uniquely |
| `zlc4` | `netgen/zlc4.log` | Circuits match uniquely |
| `zlc8` | `netgen/zlc8.log` | Circuits match uniquely |
| `zlc16` | `netgen/zlc16.log` | Circuits match uniquely |

Kết quả cuối trong `netgen/zlc16.log`:

```text
Final result: Circuits match uniquely!
```

## Post-layout simulation

Post-layout simulation được thực hiện với netlist `magic/zlc16.rcx.spice`, tức netlist đã có parasitic resistance/capacitance sau layout extraction. File `ngspice/zlc16_tb.spice` include trực tiếp netlist này bằng dòng:

```spice
.include $PWD/../magic/zlc16.rcx.spice
```

Testbench hiện tại áp 8 mẫu input trong khoảng `0 ns` đến `20 ns` để quan sát đáp ứng của `Y[4:0]`. Các mẫu gồm những trường hợp đại diện như `16'h0004`, `16'h000C`, `16'h0010`, `16'h0100`, `16'h4000`, `16'h8000`, `16'h0001` và `16'h0000`.

Chạy lại mô phỏng post-layout:

```bash
cd ngspice
ngspice -b -r zlc16.rcx.raw zlc16_tb.spice | tee zlc16_ngspice.log
```

Các thiết lập chính trong testbench:

| Hạng mục | Giá trị |
| --- | --- |
| DUT netlist | `magic/zlc16.rcx.spice` |
| Nguồn cấp | `VDD = 1.8 V`, `VSS = 0 V` |
| Transient analysis | `.tran 1ps 20ns` |
| Output load | `0.01 pF` cho mỗi output `Y0` đến `Y4` |
| Saved signals | `A15`, `A14`, `A8`, `A4`, `A3`, `A2`, `A0`, `Y0` đến `Y4` |
| Raw waveform | `ngspice/zlc16.rcx.raw` |

Log `ngspice/zlc16_ngspice.log` xác nhận batch simulation đã chạy và tạo raw waveform:

| Hạng mục trong log | Giá trị |
| --- | ---: |
| Binary raw file | `zlc16.rcx.raw` |
| Số cột dữ liệu theo log | 8 |
| Số dòng dữ liệu theo log | 20,020 |
| Total analysis time | 164.119 s |
| Total elapsed time | 201.894 s |

## Tổng kết

Project `sky130_16bit_zlc` đã hoàn thành một mạch Zero Leading Counter 16 bit theo flow thủ công trên SKY130:

- Schematic phân cấp từ `zlc2` đến `zlc16`.
- Verilog/SPICE netlist được xuất từ schematic.
- Functional simulation pass toàn bộ 65,536 input của `zlc16`.
- STA đạt timing với constraint clock ảo 10 ns.
- Layout Magic có netlist phục vụ LVS và RC parasitic netlist.
- LVS pass cho tất cả các cấp `zlc2`, `zlc4`, `zlc8`, `zlc16`.
- Post-layout simulation đã chạy trên extracted RC netlist.

