#!/bin/bash

PS3="Please enter your city of choice: "
select city in "Tokyo" "London" "Los Angeles" "Moscow" "Dubai" "Manchester" "New York" "Paris" "Bangalore" "Johannesburg" "Istanbul" "Milan" "Abu Dhabi" "Pune" "Nairobi" "Berlin" "Karachi"; do
    case "$city" in
        "London" | "Manchester")
            echo "That city is in the UK.";;
        "Los Angeles" | "New York")
            echo "That city is in the USA.";;
        "Dubai" | "Abu Dhabi")
            echo "That city is in the UAE.";;
        "Bangalore" | "Pune")
            echo "That city is in India.";;
        "Tokyo")
            echo "That city is in Japan.";;
        "Moscow")
            echo "That city is in Russia.";;
        "Paris")
            echo "That city is in France.";;    
        "Johannesburg")
            echo "That city is in South Africa.";;
        "Istanbul")
            echo "That city is in Turkey.";;
        "Milan")
            echo "That city is in Italy.";;
        "Nairobi")
            echo "That city is in Kenya.";;
        "Berlin")
            echo "That city is in Germany.";;
        "Karachi")
            echo "That city is in Pakistan.";;
        *)
            echo "Idk how you chose a city without a country??";;
    esac
    break
done