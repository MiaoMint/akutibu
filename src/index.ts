import { Hono } from 'hono'

type Bindings = {
  [key in keyof CloudflareBindings]: CloudflareBindings[key]
}

const app = new Hono<{ Bindings: Bindings }>()

app.get('/', (c) => {
  return c.text('Hello Akutibu!')
})

app.get('/akutibu',async (c) => {
  const akutibu = await c.env.STORAGE.get('akutibu')
  if (!akutibu) {
    return c.text('Not Found', { status: 404 })
  }
  return c.json(JSON.parse(akutibu))
})

app.post('/akutibu', async (c) => {
  // 鉴权
  const auth = c.req.header('Authorization')
  if (!auth || auth !== `${c.env.SECRET_KEY}`) {
    return c.text('Unauthorized', { status: 401 });
  }
  const {
    title,
    name,
    icon,
  } = await c.req.json();
  
  if (!title || !name || !icon) {
    return c.text('Missing required fields', { status: 400 });
  }

  await c.env.STORAGE.put('akutibu', JSON.stringify({
    title,
    name,
    icon,
  }));

  return c.text('OK', { status: 201 });
})

export default app