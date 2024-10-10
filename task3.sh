#!/bin/bash

echo "PassengerId, Survived, Pclass, Name, Sex, Age, SibSp, Parch, Ticket, Fare, Cabin, Embarked" > filtered_passengers.csv

# a and b. Preprocess the file by replacing male/female with M/F and filter for 2nd class (PClass) and Southampton (Embarked)
sed 's/male/M/g; s/female/F/g' titanic.csv | gawk -F',' '$3 == 2 && ($13~/S/)' >> filtered_passengers.csv

# printing the output
gawk -F',' 'NR > 1 {
    print "Name: " $4 ", Gender: " $6 ", Age: " $7
}' filtered_passengers.csv

echo "" 

# c. Calculate the average age and count of the filtered passengers
average_age=$(gawk -F',' 'NR > 1 && $7 != "" && $7 ~ /^[0-9]+(\.[0-9]+)?$/ {
    total += $7; count++
} 
END {
    if(count>0){
        print count, total, total/count
    }else{
        print "No passengers found.", 0
    }
}' filtered_passengers.csv)

count=$(echo "$average_age" | awk '{print $1}')  
total=$(echo "$average_age" | awk '{print $2}')  
avg_age=$(echo "$average_age" | awk '{print $3}')   

echo "Count of Passengers with given criteria: $count"
echo "Sum of Ages: $total"
echo "Average Age: $avg_age"


