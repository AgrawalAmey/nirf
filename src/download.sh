#! /bin/bash

set -e

download_pdfs () {
    mkdir -p rankings/$1
    pushd $1
    curl -s $2 | grep -o "https://.*\.pdf" | xargs wget
    popd
}

download_pdfs rankings/medical https://www.nirfindia.org/2018/MEDICALRanking.html
download_pdfs rankings/pharmacy https://www.nirfindia.org/2018/PharmacyRanking.html
download_pdfs rankings/colleges https://www.nirfindia.org/2018/CollegeRanking.html
download_pdfs rankings/management https://www.nirfindia.org/2018/ManagementRanking.html
download_pdfs rankings/engineering https://www.nirfindia.org/2018/EngineeringRanking.html
download_pdfs rankings/universities https://www.nirfindia.org/2018/UniversityRanking.html
download_pdfs rankings/overall https://www.nirfindia.org/2018/OverallRanking.html
download_pdfs rankings/law https://www.nirfindia.org/2018/LAWRanking.html
download_pdfs rankings/universities https://www.nirfindia.org/2018/UniversityRanking.html
download_pdfs rankings/architecture https://www.nirfindia.org/2018/ArchitectureRanking.html

# Convert files to text
echo 'Converting PDF files to text files...'
find rankings -name "*.pdf" -exec pdftotext {} \;
