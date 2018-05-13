#! /bin/bash

set -e

download_pdfs () {
    mkdir -p rankings/$1
    pushd rankings/$1
    curl -s $2 | grep -o "https://.*\.pdf" | xargs wget
    popd
}

download_pdfs medical https://www.nirfindia.org/2018/MEDICALRanking.html
download_pdfs pharmacy https://www.nirfindia.org/2018/PharmacyRanking.html
download_pdfs colleges https://www.nirfindia.org/2018/CollegeRanking.html
download_pdfs management https://www.nirfindia.org/2018/ManagementRanking.html
download_pdfs engineering https://www.nirfindia.org/2018/EngineeringRanking.html
download_pdfs universities https://www.nirfindia.org/2018/UniversityRanking.html
download_pdfs overall https://www.nirfindia.org/2018/OverallRanking.html
download_pdfs law https://www.nirfindia.org/2018/LAWRanking.html
download_pdfs architecture https://www.nirfindia.org/2018/ArchitectureRanking.html

# Convert files to text
echo 'Converting PDF files to text files...'
find rankings -name "*.pdf" -exec pdftotext {} \;