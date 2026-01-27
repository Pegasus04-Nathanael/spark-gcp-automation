from pyspark import SparkContext, SparkConf
import sys
import time

if len(sys.argv) != 3:
    print("Usage: wordcount.py <input_file> <output_dir>")
    sys.exit(1)

input_file = sys.argv[1]
output_dir = sys.argv[2]

conf = SparkConf().setAppName("WordCount")
sc = SparkContext(conf=conf)
sc.setLogLevel("ERROR")

start_time = time.time()

text = sc.textFile(input_file)
counts = text.flatMap(lambda line: line.split()) \
             .map(lambda word: (word.lower(), 1)) \
             .reduceByKey(lambda a, b: a + b)

num_words = counts.count()

# COLLECTE TOUT sur le Driver (Edge)
sorted_counts = counts.sortBy(lambda x: x[1], ascending=False).collect()

# Écris en Python normal (pas Spark)
with open(output_dir, 'w') as f:
    for word, count in sorted_counts:
        f.write(f"{word}\t{count}\n")

elapsed_time = time.time() - start_time

print(f"\n{'='*50}")
print(f"WordCount termine !")
print(f"Temps execution : {elapsed_time:.2f} secondes")
print(f"Nombre de mots uniques : {num_words}")
print(f"\nTop 10 mots :")
for word, count in sorted_counts[:10]:
    print(f"  {word}: {count}")
print(f"{'='*50}\n")

sc.stop()
