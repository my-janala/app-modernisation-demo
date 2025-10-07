#!/bin/bash

# PowerPoint Conversion Script
# Converts SLIDES.md to PowerPoint format using multiple methods

set -e

SLIDES_FILE="SLIDES_VISUAL.md"
OUTPUT_FILE="App_Modernization_Demo_Slides_Visual"

echo "PowerPoint Conversion Script for App Modernization Demo"
echo "======================================================="

# Check if SLIDES.md exists
if [ ! -f "$SLIDES_FILE" ]; then
    echo "Error: SLIDES.md not found in current directory"
    exit 1
fi

# Method 1: Try Pandoc (most reliable)
echo "Attempting conversion with Pandoc..."
if command -v pandoc &> /dev/null; then
    echo "Pandoc found. Converting to PowerPoint..."
    pandoc "$SLIDES_FILE" -o "${OUTPUT_FILE}.pptx" \
        --slide-level=2 \
        --metadata title="Konveyor Demo - Cloud Native Kubernetes Meetup" \
        --metadata author="Mezba Rahman, Platform Engineer, CIS Capgemini" \
        --metadata date="10th October 2025"
    
    if [ -f "${OUTPUT_FILE}.pptx" ]; then
        echo "Success! PowerPoint file created: ${OUTPUT_FILE}.pptx"
        echo "File size: $(ls -lh ${OUTPUT_FILE}.pptx | awk '{print $5}')"
        exit 0
    fi
else
    echo "Pandoc not found. Trying alternative method..."
fi

# Method 2: Try Marp
echo "Attempting conversion with Marp..."
if command -v marp &> /dev/null; then
    echo "Marp found. Converting to PowerPoint..."
    marp "$SLIDES_FILE" --pptx -o "${OUTPUT_FILE}.pptx"
    
    if [ -f "${OUTPUT_FILE}.pptx" ]; then
        echo "Success! PowerPoint file created: ${OUTPUT_FILE}.pptx"
        echo "File size: $(ls -lh ${OUTPUT_FILE}.pptx | awk '{print $5}')"
        exit 0
    fi
else
    echo "Marp not found. Trying HTML conversion..."
fi

# Method 3: Convert to HTML (can be imported to PowerPoint)
echo "Converting to HTML as fallback..."
if command -v pandoc &> /dev/null; then
    pandoc "$SLIDES_FILE" -o "${OUTPUT_FILE}.html" \
        --slide-level=2 \
        --self-contained \
        --metadata title="Konveyor Demo - Cloud Native Kubernetes Meetup"
    
    echo "HTML file created: ${OUTPUT_FILE}.html"
    echo "You can now:"
    echo "   1. Open ${OUTPUT_FILE}.html in a browser"
    echo "   2. Use browser's 'Print to PDF' feature"
    echo "   3. Import the PDF into PowerPoint"
    exit 0
fi

# If all methods fail, provide manual instructions
echo "No suitable conversion tools found."
echo ""
echo "Installation Options:"
echo ""
echo "Install Pandoc (Recommended):"
echo "   macOS:   brew install pandoc"
echo "   Windows: choco install pandoc"
echo "   Linux:   sudo apt-get install pandoc"
echo ""
echo "Install Marp CLI:"
echo "   npm install -g @marp-team/marp-cli"
echo ""
echo "Manual Conversion:"
echo "   1. Copy content from SLIDES.md"
echo "   2. Use online converter: https://pandoc.org/try/"
echo "   3. Paste into PowerPoint manually"
echo ""

exit 1