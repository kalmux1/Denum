#!/bin/bash

# Define colors for output
BRIGHT_RED='\033[1;31m'
BRIGHT_GREEN='\033[1;32m'
BRIGHT_CYAN='\033[1;36m'
BRIGHT_YELLOW='\033[1;33m'
BRIGHT_MAGENTA='\033[1;35m'
NC='\033[0m' # No color

# Function to display banner
show_banner() {
  echo " "
  echo -e "${BRIGHT_CYAN}	   ___  _____  ____  ____  ___${NC}"
  echo -e "${BRIGHT_CYAN}	  / _ \/ __/ |/ / / / /  |/  /${NC}"
  echo -e "${BRIGHT_CYAN}	 / // / _//    / /_/ / /|_/ /${NC}"
  echo -e "${BRIGHT_CYAN}	/____/___/_/|_/\____/_/  /_/${NC}"
  echo " "
  echo -e "${BRIGHT_CYAN}	      Author: Kalmux${NC}"
  echo " "
}

# Function to display help message
show_help() {
  echo -e "${BRIGHT_GREEN}Usage:${NC} ./denum.sh -i <domain_list_file> -o <output_file>"
  echo " "
  echo -e "Description : This tool takes a file containing domain names and retrieves subdomains from crt.sh."
  echo " "
  echo -e "${BRIGHT_GREEN}Options:${NC}"
  echo -e "  -i <file>   Specify the input file containing domain names."
  echo -e "  -o <file>   Specify the output file to save subdomains."
  echo -e "  -h          Show this help message."
  echo " "
  echo -e "${BRIGHT_GREEN}Example:${NC}"
  echo -e "  ./denum.sh -i domains.txt -o subdomains.txt"
}

# Function to clean domain names
clean_domain() {
  local domain="$1"
  # Remove scheme (http://, https://, etc.) and any trailing slashes or paths
  echo "$domain" | sed -e 's/^https\?:\/\///' -e 's/^www\.//' -e 's/\/.*$//'
}

# Show banner
show_banner

# Initialize input and output file variables
input_file=""
output_file=""

# Parse command-line options
while getopts ":i:o:h" option; do
  case "$option" in
    i) input_file="$OPTARG" ;;
    o) output_file="$OPTARG" ;;
    h) show_help
       exit 0 ;;
    ?) show_help
       exit 1 ;;
  esac
done

# Check if input and output files are provided
if [ -z "$input_file" ]; then
  echo -e "${BRIGHT_RED}Error: Input file not provided!${NC}"
  exit 1
fi

if [ -z "$output_file" ]; then
  echo -e "${BRIGHT_RED}Error: Output file not provided!${NC}"
  exit 1
fi

# Check if the input file exists
if [ ! -f "$input_file" ]; then
  echo -e "${BRIGHT_RED}Error: File $input_file not found!${NC}"
  exit 1
fi

# Clear the output file if it exists
> "$output_file"

# Loop through each domain in the input file
while read -r domain; do
  cleaned_domain=$(clean_domain "$domain")
  echo -e "${BRIGHT_MAGENTA}Fetching Subdomains for: ${NC}${BRIGHT_YELLOW}$cleaned_domain${NC}"

  # Fetch data from crt.sh and check if JSON is valid
  response=$(curl -s "https://crt.sh/?q=$cleaned_domain&output=json")

  # Check if response is valid JSON
  if echo "$response" | jq empty >/dev/null 2>&1; then
    # Process the valid JSON response
    subdomains=$(echo "$response" | \
    jq -r '.[].name_value' | \
    grep -Po '(\w+\.\w+\.\w+\.\w+|\w+\.\w+\.\w+)$')

    # Append subdomains to the output file
    echo "$subdomains" >> "$output_file"
  else
    echo -e "${BRIGHT_RED}Warning: Invalid JSON response for domain: $cleaned_domain${NC}"
  fi

done < "$input_file"

echo " "
echo -e "${BRIGHT_GREEN}Subdomains saved to $output_file${NC}"
