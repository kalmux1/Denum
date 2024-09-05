# Denum

<p align="center">
  <img src="https://github.com/kalmux1/Denum/blob/main/Assets/Denum.png" alt="Denum Tool">
</p>

## Overview

Denum is a specialized tool for the reconnaissance phase of penetration testing and is particularly valuable for bug bounty hunters. It streamlines the process of gathering and cleaning domain names from URLs, enabling users to efficiently extract and standardize core domain names and subdomains. By doing so, Denum helps extend the scope of security assessments and vulnerability research, making it an essential asset for comprehensive and effective security investigations.

## ✨ Features

- **Clean Domain Names**: Converts URLs like `https://www.example.com/` to `example.com`.
- **Handle Various URL Formats**: Supports different URL structures and protocols.
- **Error Handling**: Alerts if the input file is missing or if an invalid domain is encountered.

## 📚 Requirements

- Bash Shell
- `jq` (for JSON processing)
- `curl` (for HTTP requests)
- `grep`, `awk`, `sed` (for text processing)

## 🚀 Getting Started

1. **Clone the repository**:
    ```bash
    sudo apt-get update && sudo apt-get upgrade -y
    git clone https://github.com/kalmux1/Denum.git
    cd Denum
    sudo chmod +x denum.sh
    ```

2. **Run the script**:
    ```bash
    ./denum.sh -i input.txt -o output.txt
    ```

    - `-i <file>`: Specify the input file containing domain names.
    - `-o <file>`: Specify the output file to save cleaned domain names.

## 🛠️ How It Works

The script processes each line from the input file to extract and clean domain names. It uses a series of Bash commands to strip out unwanted URL components and then saves the cleaned domains to the specified output file.

- **clean_domain()**: Function to clean and standardize domain names from URLs.
- **Error Handling**: Alerts the user if there are issues with input files or invalid data.

## 🎥 Demo Usage

<p align="center">
  <a href="https://www.youtube.com/watch?v=HUFJjV17Bjw">
    <img src="https://img.youtube.com/vi/HUFJjV17Bjw/0.jpg" alt="Denum Demo Video">
  </a>
</p>



## 🤝 Contributing

Contributions are welcome! Please fork this repository and submit a pull request for any improvements or bug fixes.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📫 Contact

If you have any questions or feedback, feel free to reach out via [LinkedIn](https://www.linkedin.com/in/nitin-jaiswal1/) or open an issue on GitHub.

##
<div align=center>
    <a href="https://www.buymeacoffee.com/kalmux" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-green.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
</div>
