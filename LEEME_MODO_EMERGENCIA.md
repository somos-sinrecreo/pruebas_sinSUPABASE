# SIN RECREO · Modo emergencia GitHub

## Qué cambia

- `index.html` intenta cargar el catálogo desde `./data/catalog.json`.
- Si `catalog.json` existe y tiene productos, la tienda muestra catálogo sin consultar Supabase.
- El checkout queda en modo WhatsApp para no depender de Edge Functions mientras Supabase esté suspendido.
- `admin.html` ya no permite subir imágenes al Storage de Supabase; solo acepta URLs externas.

## Estructura esperada

```txt
/index.html
/admin.html
/data/catalog.json
/assets/productos/
```

## Exportar catálogo desde Supabase

1. Entrá a Supabase.
2. Abrí SQL Editor.
3. Pegá el contenido de `tools/01_exportar_catalogo_supabase.sql`.
4. Ejecutalo.
5. Copiá el JSON resultante.
6. Pegalo en `data/catalog.json`.

## Imágenes

No subas originales A3. Usá versiones web `.webp`.

Recomendación:
- miniatura/card: 900 a 1200 px de alto
- peso ideal: 80 KB a 400 KB
- nombre simple: `capsula-producto-01.webp`

Subilas a:

```txt
/assets/productos/
```

Luego en `data/catalog.json`, las URLs deben apuntar a algo así:

```txt
https://sinrecreo.com.ar/assets/productos/eraserhead-01.webp
```

## Volver a Supabase cuando la cuota vuelva

En `index.html`, dentro de `STORE_CONFIG`, cambiá:

```js
catalogSource: 'static',
emergencyWhatsappCheckout: true,
emergencyDisablePudo: true
```

por:

```js
catalogSource: 'supabase',
emergencyWhatsappCheckout: false,
emergencyDisablePudo: false
```

Y dejá las imágenes afuera de Supabase. Supabase solo debería guardar las URLs.
