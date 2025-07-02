# Huffman Compression

An implementation of Huffman encoding and decoding algorithms in x86 assembly. This project demonstrates low-level data compression techniques and bitwise operations.

## 🗜️ Features

- **Huffman Encoding**: Compress text files using the Huffman algorithm.
- **Huffman Decoding**: Decompress files back to their original content.
- **Efficient Bitwise Operations**: Handles bit-level data manipulation in assembly.
- **Modular Code**: Separate files for encoding, decoding, tree construction, and system calls.

## 🗂️ Project Structure
huffman-compression/
├── src/
│ ├── encode.asm # Huffman encoding logic
│ ├── decode.asm # Huffman decoding logic
│ ├── huffman.asm # Main program
│ ├── tree.asm # Huffman tree construction
│ └── syscalls.asm # System call wrappers
├── Makefile # Build instructions
├── README.md
└── ...

## 🛠️ Technologies Used

- **x86 Assembly**: Core implementation language
- **NASM**: Assembler for building the project
- **Linux syscalls**: File I/O and memory management

## 📝 How to Run

1. Install NASM and a suitable Linux environment.
2. Build the project: `make`
3. Run the encoder/decoder with appropriate input files.
4. Check the output files for compressed/decompressed data.

## 📚 What I Learned

- Implementing algorithms in assembly language
- Bitwise data manipulation
- File I/O at the system call level
- Data compression fundamentals

## 🤝 Contributing

This project is for learning purposes, but feel free to fork and experiment!

## 📖 Credits

Inspired by classic data compression techniques and built for educational exploration.

---

*Built with ❤️ by Muhammad Moiz for low-level programming practice*
# Huffman Compression

This repository contains the implementation of a Huffman Compression algorithm using assembly for the 64-bit x86 architecture. The program supports both encoding and decoding functionalities for compressing and decompressing data based on character frequencies. The assembly code is structured with separate modules for encoding, decoding, frequency counting, tree construction, and system calls.

## Project Structure

```
httpsmojojojo-huffman-compression/
├── README.md          # This file
├── Makefile           # Makefile to build the project
└── src/
├── decode.asm     # Assembly code for decoding
├── encode.asm     # Assembly code for encoding
├── huffman.asm    # Main entry point and Huffman algorithm driver
├── syscalls.asm   # System call macros and wrapper functions
└── tree.asm       # Assembly code for building and handling Huffman tree
````

## Overview

This project implements Huffman compression in pure assembly, optimized for 64-bit systems. It performs the following steps:

1. **Frequency Counting**: Analyzes the input string to count the frequency of each unique character.
2. **Sorting**: Sorts characters by their frequency in descending order, using a custom sorting algorithm.
3. **Tree Construction**: Builds a binary Huffman tree based on character frequencies.
4. **Encoding**: Generates and returns a compressed representation of the input string.
5. **Decoding**: Decodes the compressed data back to the original string.

### Key Features

- **Memory Efficiency**: The program uses low-level memory allocation (`mmap`) to manage memory dynamically.
- **Custom System Calls**: Implements custom system calls for writing, memory mapping, and handling exit conditions.
- **Modular Design**: The project is structured in a modular fashion, with separate files for different components of the algorithm.

## Compilation & Usage

### Compilation

To compile the project, you can use the included `Makefile`:

```bash
make
````

This will compile the `huffman.asm` source file and produce the executable `huffman`.

### Usage

The program accepts two arguments:

1. **Action**: A character to specify the action (either encoding or decoding).

   * `e` for encoding
   * `d` for decoding
2. **Input**: The string to be encoded or decoded.

Example of encoding:

```bash
./huffman e "This is a test string for Huffman compression"
```

Example of decoding:

```bash
./huffman d "encoded_string"
```

### Error Handling

* If the program is called without the correct number of arguments, it will print an error message: `Insufficient arguments`.
* If the action is invalid, it will print an error message: `Invalid action`.

## Files Explanation

* `README.md`: Project documentation.
* `Makefile`: Instructions to build the project.
* `src/decode.asm`: Contains the decoding logic for the Huffman algorithm.
* `src/encode.asm`: Contains the encoding logic for the Huffman algorithm.
* `src/huffman.asm`: The main driver file, which checks the arguments and orchestrates the encoding or decoding process.
* `src/syscalls.asm`: Provides macros for common system calls, such as memory allocation and printing.
* `src/tree.asm`: Contains the logic for building and managing the Huffman tree.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
