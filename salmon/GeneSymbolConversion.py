from sys import *
EnsToGS = {}
for line in open(argv[1], "r"):
    parts = line.strip().split("\t")
    if len(parts) < 2:
        continue
    EnsToGS[parts[0]] = parts[1]

first = True
for line in open(argv[2], "r"):
    if first:
        print(line.strip())
        first = False
    parts = line.strip().split("\t")
    StrippedID = parts[0].split(".")[0]
    if StrippedID in EnsToGS:
        print(EnsToGS[StrippedID] +"\t" + "\t".join(parts[1:]))

