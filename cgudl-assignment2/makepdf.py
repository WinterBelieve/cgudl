import argparse
import os
import subprocess

try:
    from PyPDF2 import PdfMerger
    MERGE = True
except ImportError:
    print("Could not find PyPDF2. Leaving pdf files unmerged.")
    MERGE = False

def main(files):
    for f in files:
        subprocess.run([
            "jupyter",
            "nbconvert",
            "--log-level",
            "CRITICAL",
            "--to",
            "pdf",
            f,
        ])
        print(f"Created PDF {f}.")

    if MERGE:
        pdfs = [f.split(".")[0] + ".pdf" for f in files]
        merger = PdfMerger()
        for pdf in pdfs:
            merger.append(pdf)
        merger.write("assignment2.pdf")
        merger.close()

        for pdf in pdfs:
            os.remove(pdf)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--notebooks", type=str, nargs="+", required=True)
    args = parser.parse_args()
    main(args.notebooks)
