-- SIN RECREO · Export de catálogo para modo emergencia GitHub
-- 1) Pegá y ejecutá esto en Supabase > SQL Editor.
-- 2) Copiá el resultado JSON.
-- 3) Guardalo como data/catalog.json en tu repo de GitHub Pages.
-- 4) Después reemplazá las URLs de Supabase Storage por URLs nuevas de GitHub/Cloudflare.

select jsonb_pretty(
  jsonb_build_object(
    'products',
      coalesce((
        select jsonb_agg(to_jsonb(p) order by p.featured desc, p.sort_date desc nulls last, p.created_at desc nulls last)
        from products p
        where p.is_active is distinct from false
      ), '[]'::jsonb),
    'product_images',
      coalesce((
        select jsonb_agg(to_jsonb(pi) order by pi.product_id, pi.position)
        from product_images pi
      ), '[]'::jsonb),
    'blank_stock',
      coalesce((
        select jsonb_agg(to_jsonb(bs) order by bs.cut, bs.color, bs.size)
        from blank_stock bs
      ), '[]'::jsonb),
    'capsules',
      coalesce((
        select jsonb_agg(to_jsonb(c) order by c.is_featured_drop desc, c.name asc)
        from capsules c
        where c.is_active is distinct from false
      ), '[]'::jsonb)
  )
) as catalog_json;
