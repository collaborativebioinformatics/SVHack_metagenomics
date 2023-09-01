#grep -oP '(?<=, "score": ).*?(?=,)' 5AssembliesForTestingAcc.fa.gz.fd8c760.417fcdf.11fe66b.smooth.final.pruned.mod.json > score.json

number_counts = {}
with open('score.json', 'r') as file:
    # Read each line in the file
    for line in file:
        # Convert the line to an integer
        number = int(line.strip())

        if number in number_counts:
            # If it is, increment the count
            number_counts[number] += 1
        else:
            # If it's not, add it to the dic with a count of 1
            number_counts[number] = 1

total_count=1690224
for number, count in number_counts.items():
    number_counts[number] = 100 * number_counts[number] / total_count #remove for figure 0
    print(f'Number: {number}, Count: {count / total_count}')

import matplotlib.pyplot as plt
import collections
number_counts = collections.OrderedDict(sorted(number_counts.items())) #figure 2
cumulated = 0
for keys in number_counts:#figure 3
    cumulated += number_counts[keys]
    number_counts[keys] = cumulated 
#plt.bar(list(number_counts.keys()), number_counts.values(), color='g') #figure 1
plt.plot(number_counts.keys(), number_counts.values())
#plt.title("Quality score distribution of the MAPQ sampling")
plt.title("Selectivity of the quality filter threshold") #figure3
#plt.xlabel('Quality score value')
plt.xlabel('Value of quality filter threshold') #figure3
#plt.ylabel('Percentage of reads')
plt.ylabel('Percentage of reads failing quality filter') #figure3
plt.show()
plt.savefig("figure3.png")

plt.style.use('default')

