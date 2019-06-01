# Deputies

This module allows to download the data from the Chamber of Deputies of Brazil's API about the members of the Chamber.

Use the command to download and process the data:

```
Rscript export_deputies.R -o output.csv -l 56
```

-o: path of output to the csv file generate by the script
-l: number of legislature to get the deputies. 56 is the actual legislature.

Run help to more info

```
Rscript export_deputies.R --help 
```

