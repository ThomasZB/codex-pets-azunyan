# Azunyan Codex Pet

Azunyan is a custom Codex pet packaged for the Codex app. The current package
uses the v2 sprite format and includes 16 clockwise looking directions.

## Preview

![Azunyan contact sheet](preview/contact-sheet.png)

## Files

- `pet.json` - Codex pet manifest
- `spritesheet.webp` - v2 animated pet spritesheet (`1536x2288`, 8 columns x 11 rows)
- `preview/contact-sheet.png` - QA contact sheet preview

## Install

Install Azunyan with one command:

```bash
curl -fsSL https://raw.githubusercontent.com/ThomasZB/codex-pets-azunyan/main/install.sh | sh
```

The installer replaces an existing Azunyan installation at
`~/.codex/pets/azunyan`. Restart Codex if the updated pet does not appear
immediately.

## Display Size

Use the pet size control in Codex to adjust Azunyan's displayed size. Separate
80%, 90%, and 105% image packages are no longer needed.

Do not resize the spritesheet itself. The v2 atlas must remain `1536x2288`
with fixed `192x208` cells so Codex can slice all standard animations and look
directions correctly.
