#!/bin/bash

PS3="Please enter your city of choice: "
select city in "Tokyo" "London" "Los Angeles" "Moscow" "Dubai" "Manchester" "New York" "Paris" "Bangalore" "Johannesburg" "Istanbul" "Milan" "Abu Dhabi" "Pune" "Nairobi" "Berlin" "Karachi"; do
    
    case "$city" in
        "London" | "Manchester")
            country="UK";;
        "Los Angeles" | "New York")
            country="USA";;
        "Dubai" | "Abu Dhabi")
            country="UAE";;
        "Bangalore" | "Pune")
            country="India";;
        "Tokyo")
            country="Japan";;
        "Moscow")
            country="Russia";;
        "Paris")
            country="France";;
        "Johannesburg")
            country="South Africa";;
        "Istanbul")
            country="Turkey";;
        "Milan")
            country="Italy";;
        "Nairobi")
            country="Kenya";;
        "Berlin")
            country="Germany";;
        "Karachi")
            country="Pakistan";;
        *)
            echo "Idk how you chose a city without a country??";;
    esac

    echo "That city is in $country."

    break
done