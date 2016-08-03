#!/bin/bash
spinner()
{
    local pid=$!
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c] Your loading here " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf '\b%.0s' {1..60}
    done
    printf "[OK] Its done!" 
}



(sleep 5) & spinner


printf "\n\n"

progressBarWidth=20

# Function to draw progress bar
# author: someone on stackoverflow
progressBar () {

  # Calculate number of fill/empty slots in the bar
  progress=$(echo "$progressBarWidth/$taskCount*$tasksDone" | bc -l)  
  fill=$(printf "%.0f\n" $progress)
  if [ $fill -gt $progressBarWidth ]; then
    fill=$progressBarWidth
  fi
  empty=$(($fill-$progressBarWidth))

  # Percentage Calculation
  percent=$(echo "100/$taskCount*$tasksDone" | bc -l)
  percent=$(printf "%0.2f\n" $percent)
  if [ $(echo "$percent>100" | bc) -gt 0 ]; then
    percent="100.00"
  fi

  # Output to screen
  printf "\r["
  printf "%${fill}s" "" | sed 's/ /\xE2\x96\x89/g'
  printf "%${empty}s" "" | sed 's/ /\xE2\x96\x91/g'
  printf "] $percent%% - $text "
}



# Collect task count
taskCount=33
tasksDone=0

while [ $tasksDone -le $taskCount ]; do

  # Do your task
  (( tasksDone += 1 ))
# Add some friendly output
  text=$(echo "somefile-$tasksDone.dat")

  # Draw the progress bar
  progressBar $taskCount $taskDone $text

  sleep 0.01
done

echo


