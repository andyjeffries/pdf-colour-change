# PDF Colour Change

There is a tiny percentage of people that struggle to read black text on a white background. My wife had a student that had this issue, so I wrote a script to take a PDF and using various filters change the colour mapping to colourise it from black-on-white to blue-on-cream.

The important purpose of this script (for the student's exams) has now finished, but rather than just destroy the work, I thought it may be useful to someone else in the future.

## Instructions for use

This is a pretty simple "shell script" that can just work as-is, but to ensure you have all the required dependencies, it's packaged as a "Docker" container. I'll give instructions on how to use it below, but these expect that you know how to use Docker (i.e. the instructions are specific to this script, if you don't know Docker, I'd recommend doing some YouTube searching first) and have Docker installed.

```sh
git clone https://github.com/andyjeffries/pdf-colour-change.git
cd pdf-colour-change

docker build -t pdf-colour-change:latest .
cp some_directory/some_file.pdf .
docker run --rm -v $(pwd):/app pdf-colour-change:latest /app/pdf-change.sh ./some_file.pdf
```

(Obviously replace `some_file.pdf` with the name of your actual PDF to convert)

The file size will increase dramatically, PDF files are normally the text described on the page - this script converts each page to a page of dots (i.e. an image of the text), then filters the colours and then makes a new PDF where each page is effectively a photo of the text, rather than the original text.

It should look like this though:

![screenshot](./screenshot.png)
