# -*- coding: utf-8 -*-
"""One-off: extract ppt/media/* into ./assets/"""
import os
import zipfile
import glob

pptx = [p for p in glob.glob("*.pptx") if not p.startswith("~$")][0]
os.makedirs("assets", exist_ok=True)
with zipfile.ZipFile(pptx) as z:
    for name in z.namelist():
        if name.startswith("ppt/media/image") and not name.endswith("/"):
            base = os.path.basename(name)
            out = os.path.join("assets", base)
            with open(out, "wb") as f:
                f.write(z.read(name))
            print("wrote", out)
