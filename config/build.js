#!/usr/bin/env node
const esbuild = require('esbuild')

const watch = process.argv.includes('--watch')
const clients = []

const buildOptions = {
  entryPoints: ['app/javascript/application.ts'],
  bundle: true,
  outdir: 'app/assets/builds',
  sourcemap: true,
  publicPath: '/assets',
  watch: watch && {
    onRebuild(error, result) {
      if (error) console.error('Build failed:', error)
      else console.log('Build succeeded')
    },
  },
}

async function build() {
  try {
    await esbuild.build(buildOptions)
    if (watch) {
      console.log('Watching for changes...')
    }
  } catch (error) {
    console.error('Build failed:', error)
    process.exit(1)
  }
}

build()
