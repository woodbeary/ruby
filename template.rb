def source_paths
  [__dir__]
end

# Add gems
gem 'view_component'
gem 'tailwindcss-rails'

# Add TypeScript and other npm packages
after_bundle do
  run "npm init -y"
  run "npm install @hotwired/stimulus @hotwired/turbo-rails esbuild typescript --save"
  
  # Create TypeScript config
  create_file "tsconfig.json", <<~JSON
    {
      "compilerOptions": {
        "target": "es2020",
        "module": "es2020",
        "moduleResolution": "node",
        "strict": true,
        "jsx": "preserve",
        "sourceMap": true,
        "resolveJsonModule": true,
        "esModuleInterop": true,
        "lib": ["es2020", "dom"],
        "rootDir": "app/javascript",
        "outDir": "app/assets/builds"
      },
      "include": ["app/javascript/**/*"]
    }
  JSON

  # Set up build configuration
  create_file "config/build.js", <<~JS
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
  JS

  # Create Procfile.dev
  create_file "Procfile.dev", <<~PROCFILE
    web: bin/rails server -p 3000
    js: npm run watch
    css: bin/rails tailwindcss:watch
  PROCFILE

  # Update package.json scripts
  run "npm pkg set scripts.build=\"esbuild app/javascript/application.ts --bundle --sourcemap --outdir=app/assets/builds\""
  run "npm pkg set scripts.watch=\"esbuild app/javascript/application.ts --bundle --sourcemap --outdir=app/assets/builds --watch\""

  # Make build script executable
  run "chmod +x bin/dev"

  # Initial TypeScript setup
  create_file "app/javascript/application.ts", <<~TS
    import "@hotwired/turbo-rails"
    import { Application } from "@hotwired/stimulus"

    const application = Application.start()
    window.Stimulus = application

    export { application }
  TS

  # Set up basic ViewComponent
  generate "component Navigation current_user:object"
end
