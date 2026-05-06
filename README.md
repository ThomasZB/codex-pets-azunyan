# Azunyan Codex Pet

Azunyan is a custom Codex pet packaged for the Codex app.

## Files

- `pet.json` - Codex pet manifest
- `spritesheet.webp` - animated pet spritesheet
- `preview/contact-sheet.png` - QA contact sheet preview
- `variants/` - alternate scale packages

## Install

Copy the pet folder into your Codex pets directory:

```bash
mkdir -p ~/.codex/pets/azunyan
cp pet.json spritesheet.webp ~/.codex/pets/azunyan/
```

Restart Codex if the pet does not appear immediately.

## Scale Variants

Codex pet atlases should stay `1536x1872` with `192x208` cells. Do not resize
the whole spritesheet image directly, because Codex slices the atlas by fixed
cell geometry. The scale variants keep the atlas dimensions fixed and resize the
pet inside each cell.

Available variants:

- `variants/azunyan-80` - 80% scale
- `variants/azunyan-90` - 90% scale
- `variants/azunyan-105` - 105% scale

Install a variant the same way:

```bash
mkdir -p ~/.codex/pets/azunyan-90
cp variants/azunyan-90/pet.json variants/azunyan-90/spritesheet.webp ~/.codex/pets/azunyan-90/
```
