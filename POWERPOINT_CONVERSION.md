# PowerPoint Conversion Guide

This guide provides multiple methods to convert the SLIDES.md file to PowerPoint format for professional presentations.

## Method 1: Using Pandoc (Recommended)

### Prerequisites
```bash
# Install Pandoc (macOS with Homebrew)
brew install pandoc

# Or download from: https://pandoc.org/installing.html
```

### Convert to PowerPoint
```bash
# Navigate to the demo directory
cd /path/to/app-modernisation-demo

# Convert slides to PowerPoint
pandoc SLIDES.md -o "App_Modernization_Demo_Slides.pptx" \
  --slide-level=2 \
  --reference-doc=template.pptx

# Or without custom template
pandoc SLIDES.md -o "App_Modernization_Demo_Slides.pptx" --slide-level=2
```

### Advanced Options
```bash
# With custom styling and metadata
pandoc SLIDES.md -o "App_Modernization_Demo_Slides.pptx" \
  --slide-level=2 \
  --metadata title="App Modernization with Konveyor" \
  --metadata author="Your Name" \
  --metadata date="$(date +%Y-%m-%d)" \
  --toc \
  --template=custom-template.pptx
```

## Method 2: Using Marp (Modern Presentation Tool)

### Prerequisites
```bash
# Install Marp CLI
npm install -g @marp-team/marp-cli

# Or using yarn
yarn global add @marp-team/marp-cli
```

### Convert with Marp
```bash
# Convert to PowerPoint
marp SLIDES.md --pptx -o "App_Modernization_Demo_Slides.pptx"

# With custom theme
marp SLIDES.md --theme custom-theme.css --pptx -o "App_Modernization_Demo_Slides.pptx"
```

## Method 3: Online Conversion Tools

### Recommended Online Tools
1. **Slidify** - https://slidify.org/
2. **GitPitch** - https://gitpitch.com/
3. **Slides.com** - https://slides.com/
4. **Markdown to PowerPoint** - Various online converters

### Steps for Online Conversion
1. Copy content from SLIDES.md
2. Upload to chosen platform
3. Apply styling and formatting
4. Export as PowerPoint (.pptx)

## Method 4: Manual Import to PowerPoint

### Using PowerPoint's Import Feature
1. Open Microsoft PowerPoint
2. Go to **File > Import > From Text File**
3. Select the SLIDES.md file
4. Choose import options:
   - Slide breaks on H2 headings (##)
   - Bullet points from markdown lists
   - Code blocks as text boxes

### Post-Import Formatting
- Apply consistent theme and fonts
- Format code blocks with monospace font
- Add visual elements (shapes, icons, images)
- Adjust slide layouts for better presentation

## Method 5: Custom PowerPoint Template

I'll create a PowerPoint-optimized version of the slides for direct copy-paste into PowerPoint.

### Slide Structure for PowerPoint
```
Slide 1: Title Slide
- Title: App Modernization with Konveyor
- Subtitle: Automated Assessment for Legacy Applications
- Presenter details
- Date and audience

Slide 2: Agenda
- Bullet points for each section
- Time allocations
- Clear visual hierarchy

[Continue with structured content...]
```

## PowerPoint Best Practices

### Visual Design
- **Consistent Theme**: Use corporate colors and fonts
- **Readable Fonts**: Arial, Calibri, or Segoe UI (minimum 18pt)
- **High Contrast**: Dark text on light backgrounds
- **Minimal Text**: 6x6 rule (max 6 bullets, 6 words each)

### Code Formatting
- **Monospace Font**: Consolas, Courier New, or Fira Code
- **Syntax Highlighting**: Use PowerPoint's code formatting
- **Readable Size**: Minimum 14pt for code blocks
- **Contrasting Colors**: Dark background for code snippets

### Visual Elements
- **Icons**: Use consistent icon library (Microsoft 365 icons)
- **Charts**: Convert tables to visual charts where appropriate
- **Images**: Add relevant screenshots of Konveyor UI
- **Animations**: Minimal, professional entrance effects

## Automation Script

Here's a PowerShell script to automate the conversion process:

```powershell
# PowerPoint-Conversion-Script.ps1

param(
    [string]$InputFile = "SLIDES.md",
    [string]$OutputFile = "App_Modernization_Demo_Slides.pptx",
    [string]$Method = "pandoc"
)

Write-Host "Converting $InputFile to PowerPoint format..." -ForegroundColor Green

switch ($Method) {
    "pandoc" {
        if (Get-Command pandoc -ErrorAction SilentlyContinue) {
            pandoc $InputFile -o $OutputFile --slide-level=2
            Write-Host "Conversion completed using Pandoc!" -ForegroundColor Green
        } else {
            Write-Host "Pandoc not installed. Please install from https://pandoc.org/" -ForegroundColor Red
        }
    }
    "marp" {
        if (Get-Command marp -ErrorAction SilentlyContinue) {
            marp $InputFile --pptx -o $OutputFile
            Write-Host "Conversion completed using Marp!" -ForegroundColor Green
        } else {
            Write-Host "Marp not installed. Run 'npm install -g @marp-team/marp-cli'" -ForegroundColor Red
        }
    }
    default {
        Write-Host "Unsupported method. Use 'pandoc' or 'marp'" -ForegroundColor Red
    }
}
```

## Quick Start Commands

### For macOS/Linux
```bash
# One-liner setup and conversion
brew install pandoc && pandoc SLIDES.md -o "App_Modernization_Demo_Slides.pptx" --slide-level=2
```

### For Windows
```powershell
# Using Chocolatey
choco install pandoc
pandoc SLIDES.md -o "App_Modernization_Demo_Slides.pptx" --slide-level=2
```

## Troubleshooting

### Common Issues and Solutions

**Issue: Code blocks not formatting correctly**
```bash
# Solution: Use --preserve-tabs option
pandoc SLIDES.md -o slides.pptx --slide-level=2 --preserve-tabs
```

**Issue: Slides too crowded**
```bash
# Solution: Increase slide break frequency
pandoc SLIDES.md -o slides.pptx --slide-level=3
```

**Issue: Missing fonts in PowerPoint**
- Install recommended fonts (Consolas, Calibri)
- Use PowerPoint's font substitution dialog
- Embed fonts in the presentation file

**Issue: Large file size**
- Compress images before adding
- Use PowerPoint's built-in compression tools
- Remove unused slide layouts and themes

## Post-Conversion Checklist

### Content Review
- [ ] All slides converted correctly
- [ ] Code blocks are readable
- [ ] Bullet points properly formatted
- [ ] Tables converted to readable format
- [ ] Links and references maintained

### Visual Enhancement
- [ ] Apply consistent theme
- [ ] Add company branding
- [ ] Insert relevant images/screenshots
- [ ] Format code blocks for readability
- [ ] Add slide numbers and footers

### Technical Validation
- [ ] Test on target presentation system
- [ ] Verify font compatibility
- [ ] Check slide transitions
- [ ] Validate embedded media
- [ ] Test presenter notes functionality

## Alternative Formats

### If PowerPoint isn't available, consider:
1. **Google Slides** - Convert using same methods, then import
2. **LibreOffice Impress** - Open PowerPoint files directly
3. **Keynote** - Import PowerPoint files on macOS
4. **PDF Export** - Use Pandoc to create PDF slides
5. **HTML Slides** - Use reveal.js or similar frameworks

## Template Customization

### Creating Custom PowerPoint Templates
1. Design master slides in PowerPoint
2. Save as .potx template file
3. Use with Pandoc: `--reference-doc=custom-template.potx`
4. Maintain consistent branding across presentations

---

*This guide ensures professional PowerPoint presentations while maintaining the technical content and structure of the markdown slides.*