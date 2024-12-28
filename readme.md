# AES Verilog Project

This repository contains Verilog code for implementing the AES (Advanced Encryption Standard) algorithm. The project includes modules for AES encryption along with a testbench for verification.

## Requirements
Make sure you have the following tools installed on your system:

1. **Git**: To clone the repository.
   - Installation command (Linux/Ubuntu): `sudo apt install git`
   - For Windows, download Git from [git-scm.com](https://git-scm.com/).

2. **Icarus Verilog (iverilog)**: To compile and simulate Verilog code.
   - Installation command (Linux/Ubuntu): `sudo apt install iverilog`

3. **GTKWave**: To view simulation waveforms.
   - Installation command (Linux/Ubuntu): `sudo apt install gtkwave`

---

## Steps to Clone and Run the Program

### 1. Clone the Repository

Open a terminal and navigate to the directory where you want to clone this repository:
```bash
cd /path/to/your/desired/folder
```
Clone the repository using Git:
```bash
git clone https://github.com/Zeven100/AES_project.git
```

Navigate into the cloned directory:
```bash
cd AES_project
```

---

### 2. Compile the Testbench

The testbench file simulates the AES design. Compile it using the following command:
```bash
iverilog -o sim tb.v
```
Here:
- `-o sim`: Specifies the name of the output simulation file.

---

### 3. Run the Simulation

Run the compiled simulation file using:
```bash
vvp sim
```
This generates a `.vcd` (Value Change Dump) file (here , `tb.vcd`) containing waveform data for the simulation.

---

### 4. View the Waveform

Open the waveform file in GTKWave to analyze the signal transitions:
```bash
gtkwave tb.vcd
```
Use the GUI to add signals to the waveform viewer and verify the design.

---

## Troubleshooting

- **Error during compilation**: Check the syntax in your Verilog files and ensure all modules are properly instantiated.
- **No `.vcd` file generated**: Verify that the `$dumpfile` and `$dumpvars` commands are included in the testbench.

---

Feel free to contribute to this project by submitting issues or pull requests!
## About AES
Visit this link to learn more about AES ( Advanced Encryption Standard ) -> https://grass-heath-fad.notion.site/Advanced-Encryption-Standard-using-Verilog-15921e3f0ace8050b305e117d39b0f05
