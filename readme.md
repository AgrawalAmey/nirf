# NIRF

For mining and analyzing information uploaded on Nation Institute Ranking Framework.

## Downloading PDFs

PDFs for all the institutes of all categories are download and converted into text files by the following command.

```bash
> pushd src
> ./download.sh
> popd
```

## Parse the text files to create JSONs

The `process.py` file creates JSONs from the output of `pdftotext` using `TextFSM`.

```bash
> pushd src
> python3 process.py
# Convert strings to int
> find rankings -name "*.json" -exec perl -i -p -e 's/"(\d+)"/$1/g' {} \;
> popd 
```

Disclaimer: Some of the files might not get correctly parsed and might need some manual effort.

## Analyzing the data

The notebook `NIRF Analysis.ipynb` contains the source for all the analysis and plots.