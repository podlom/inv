# Pricing Page

A modern, responsive pricing page built with React, TypeScript, and Tailwind CSS. This application features internationalization support, dynamic project galleries, customer reviews, and an elegant pricing section.

## 🚀 Features

- **Modern UI/UX**: Built with Tailwind CSS and Framer Motion for smooth animations
- **Internationalization**: Support for English, Ukrainian, and Russian languages
- **Responsive Design**: Optimized for all device sizes
- **Dynamic Content**: Fetches and displays project data with fallback support
- **Customer Reviews**: Interactive review section with modal dialogs
- **Pricing Cards**: Beautiful pricing section with feature comparisons
- **Performance Optimized**: Built with Vite for fast development and optimized builds

## 🛠️ Tech Stack

- **Frontend Framework**: React 19.1.0
- **Language**: TypeScript
- **Styling**: Tailwind CSS 4.1.8
- **Build Tool**: Vite 6.3.5
- **Animations**: Framer Motion 12.15.0
- **UI Components**: Radix UI primitives
- **Internationalization**: i18next with React integration
- **Carousel**: Embla Carousel React
- **Icons**: Lucide React

## 📦 Installation

Make sure you have [Bun](https://bun.sh/) installed on your system.

```bash
# Install dependencies
bun install
```

## 🚀 Development

```bash
# Start development server
bun run dev
```

The application will be available at `http://localhost:3000`

## 🏗️ Build

```bash
# Build for production
bun run build
```

The built files will be generated in the `dist/` directory.

## 🔍 Preview

```bash
# Preview production build
bun run preview
```

## 📁 Project Structure

```
src/
├── assets/           # Static assets (images, icons)
├── components/       # React components
│   ├── blocks/       # Page section components
│   └── ui/           # Reusable UI components
├── data/             # Static data files
├── hooks/            # Custom React hooks
├── i18n/             # Internationalization setup
│   └── locales/      # Translation files (en, uk, ru)
├── lib/              # Utility functions
└── types/            # TypeScript type definitions
```

## 🌐 Internationalization

The application supports three languages:

- **English** (`en`)
- **Ukrainian** (`uk`) - Default
- **Russian** (`ru`)

Translation files are located in `src/i18n/locales/`. To add a new language:

1. Create a new JSON file in `src/i18n/locales/`
2. Add the language configuration in `src/i18n/index.ts`
3. Update the language switcher component

## 🎨 Styling

The project uses Tailwind CSS with custom configurations:

- **Font**: Montserrat (loaded from Google Fonts)
- **Custom animations**: Enhanced with `tw-animate-css`
- **Component variants**: Managed with `class-variance-authority`

## 📱 Components

### Main Sections

- **Hero**: Landing section with main call-to-action
- **PricingSection**: Pricing cards with feature comparisons
- **Gallery**: Dynamic project showcase with API integration
- **ReviewsSection**: Customer testimonials with modal interactions

### UI Components

- **PricingCard**: Individual pricing plan display
- **ProjectCard**: Project showcase with skeleton loading
- **ReviewCard**: Customer review display
- **ReviewModal**: Full review modal dialog

## 🔧 Configuration

### Vite Configuration

- **Base URL**: `/pricing-page/dist/`
- **Development Port**: 3000
- **Path Aliases**: `@` points to `src/`
- **Asset Naming**: Consistent naming for production builds

### Build Output

- Entry files: `assets/[name].js`
- Chunks: `assets/[name].js`
- Assets: `assets/[name].[ext]`

## 🚀 Deployment

The application is configured to be deployed at `/pricing-page/dist/`. Make sure your web server is configured to serve the built files from this path.

## 🧪 Linting

```bash
# Run ESLint
bun run lint
```

The project uses ESLint with TypeScript and React-specific rules for code quality.

## 📄 License

This project is private and not intended for public distribution.

## 🤝 Contributing

This is a private project. Please follow the established coding standards and ensure all changes are properly tested before submitting.
