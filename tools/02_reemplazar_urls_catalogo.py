#!/usr/bin/env python3
"""
SIN RECREO · Reemplazar URLs de Supabase Storage por URLs de GitHub/Cloudflare.

Uso:
  python tools/02_reemplazar_urls_catalogo.py data/catalog.json \
    --old "https://xedhdojvynmwaadmkcby.supabase.co/storage/v1/object/public/product-images/" \
    --new "https://sinrecreo.com.ar/assets/productos/"

Esto solo cambia los textos de URL dentro del JSON.
Antes tenés que subir las imágenes optimizadas a /assets/productos/ con los mismos nombres/rutas
o adaptar los nombres manualmente.
"""
import argparse
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument("json_file")
parser.add_argument("--old", required=True)
parser.add_argument("--new", required=True)
args = parser.parse_args()

path = Path(args.json_file)
txt = path.read_text(encoding="utf-8")
txt2 = txt.replace(args.old, args.new)
backup = path.with_suffix(path.suffix + ".bak")
backup.write_text(txt, encoding="utf-8")
path.write_text(txt2, encoding="utf-8")
print(f"Listo. Backup: {backup}")
