# Huffman Compression

This repository contains the implementation of a Huffman Compression algorithm using assembly for the 64-bit x86 architecture. The program supports both encoding and decoding functionalities for compressing and decompressing data based on character frequencies. The assembly code is structured with separate modules for encoding, decoding, frequency counting, tree construction, and system calls.

## 🗜️ Features

- **Memory Efficiency**: The program uses low-level memory allocation (`mmap`) to manage memory dynamically.
- **Huffman Encoding**: Compress text files using the Huffman algorithm.
- **Huffman Decoding**: Decompress files back to their original content.
- **Efficient Bitwise Operations**: Handles bit-level data manipulation in assembly.
- **Modular Code**: Separate files for encoding, decoding, tree construction, and system calls.
- **Modular Design**: The project is structured in a modular fashion, with separate files for different components of the algorithm.
- **Custom System Calls**: Implements custom system calls for writing, memory mapping, and handling exit conditions.

## 🗂️ Project Structure

```
huffman-compression/
├── src/
│ ├── encode.asm # Huffman encoding logic
│ ├── decode.asm # Huffman decoding logic
│ ├── huffman.asm # Main program
│ ├── tree.asm # Huffman tree construction
│ └── syscalls.asm # System call wrappers
├── Makefile # Build instructions
└── README.md
```

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

*Built with ❤️ by Muhammad Moiz*
