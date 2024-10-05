API_URL="https://api.kanye.rest/"

user=${USERNAME}

# Change to your local language if you'd like
export LANG=en_US
d=$(date '+%A, %d-%B, %Y')
hour=$(date +%H)

if [ "$hour" -lt 12 ]; then
    greeting="Good morning"
elif [ "$hour" -lt 18 ]; then
    greeting="Good day"
elif [ "$hour" -lt 21 ]; then
    greeting="Good afternoon"
else
    greeting="Good evening"
fi

if command -v curl &> /dev/null; then
    response=$(curl -s "$API_URL")
elif command -v wget &> /dev/null; then
    response=$(wget -q -O - "$API_URL")
else
    echo "Kanye speaks through either curl or wget. Install at least one of them."
    exit 1
fi

quote=$(echo "$response" | grep -o '"quote":"[^"]*' | sed 's/"quote":"//')

echo
echo "$greeting, $user. It is $d"
if [ $? -eq 0 ]; then
    echo
    echo "\x1b[37;49;1mKanye says:\x1b[32;49;1;3m \"$quote\"\033[0m"
fi
echo