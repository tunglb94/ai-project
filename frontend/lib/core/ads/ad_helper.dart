<html lang="en"><head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor AI - Advanced Medical Technology</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');
        
        body {
            font-family: 'Poppins', sans-serif;
            overflow-x: hidden;
        }
        
        .lab-background {
            position: relative;
            overflow: hidden;
            background-color: #0a1128;
        }
        
        .futuristic-lab {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
        }
        
        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(10,17,40,0.7) 0%, rgba(10,17,40,0.3) 100%);
            z-index: 1;
        }
        
        .hologram {
            position: absolute;
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(0,149,255,0.3) 0%, rgba(0,149,255,0.1) 70%, rgba(0,149,255,0) 100%);
            box-shadow: 0 0 20px #0095ff, 0 0 40px #0095ff;
            animation: pulse 4s infinite;
            z-index: 2;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); opacity: 0.7; }
            50% { transform: scale(1.1); opacity: 1; }
            100% { transform: scale(1); opacity: 0.7; }
        }
        
        .data-stream {
            position: absolute;
            width: 2px;
            background: linear-gradient(to bottom, transparent, #0095ff, transparent);
            animation: dataFlow 3s infinite;
            z-index: 2;
        }
        
        @keyframes dataFlow {
            0% { transform: translateY(-100%); }
            100% { transform: translateY(100%); }
        }
        
        .download-btn {
            transition: all 0.3s ease;
            z-index: 10;
        }
        
        .download-btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
        
        .floating {
            animation: floating 3s infinite ease-in-out;
        }
        
        @keyframes floating {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-15px); }
            100% { transform: translateY(0px); }
        }
        
        .lab-equipment {
            position: absolute;
            animation: glow 4s infinite alternate;
            z-index: 2;
        }
        
        @keyframes glow {
            0% { filter: drop-shadow(0 0 2px rgba(0,149,255,0.7)); }
            100% { filter: drop-shadow(0 0 10px rgba(0,149,255,1)); }
        }
        
        .particles {
            position: absolute;
            width: 100%;
            height: 100%;
            z-index: 2;
        }
        
        .particle {
            position: absolute;
            background-color: rgba(0,149,255,0.5);
            border-radius: 50%;
            animation: float-up linear infinite;
        }
        
        .hexagon {
            clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%);
            z-index: 2;
        }
        
        .circle-decoration {
            position: absolute;
            border-radius: 50%;
            border: 2px solid rgba(0,149,255,0.3);
            animation: expand 10s infinite alternate;
            z-index: 2;
        }
        
        @keyframes expand {
            0% { transform: scale(1); opacity: 0.3; }
            100% { transform: scale(1.5); opacity: 0.1; }
        }
        
        .nav-link {
            position: relative;
            transition: all 0.3s ease;
        }
        
        .nav-link::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -2px;
            left: 0;
            background-color: #0095ff;
            transition: width 0.3s ease;
        }
        
        .nav-link:hover::after {
            width: 100%;
        }
        
        .nav-link.active::after {
            width: 100%;
        }
        
        .scanner-line {
            position: absolute;
            height: 2px;
            background: linear-gradient(90deg, transparent, #0095ff, transparent);
            width: 100%;
            animation: scan 3s linear infinite;
            z-index: 2;
        }
        
        @keyframes scan {
            0% { top: 0%; opacity: 1; }
            50% { opacity: 0.5; }
            100% { top: 100%; opacity: 1; }
        }
        
        .digital-circle {
            position: absolute;
            border: 1px solid rgba(0,149,255,0.5);
            border-radius: 50%;
            animation: rotate 20s linear infinite;
            z-index: 2;
        }
        
        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .digital-circle::before,
        .digital-circle::after {
            content: '';
            position: absolute;
            width: 10px;
            height: 10px;
            background-color: #0095ff;
            border-radius: 50%;
        }
        
        .digital-circle::before {
            top: 0;
            left: 50%;
            transform: translateX(-50%);
        }
        
        .digital-circle::after {
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
        }
    </style>
<style>*, ::before, ::after{--tw-border-spacing-x:0;--tw-border-spacing-y:0;--tw-translate-x:0;--tw-translate-y:0;--tw-rotate:0;--tw-skew-x:0;--tw-skew-y:0;--tw-scale-x:1;--tw-scale-y:1;--tw-pan-x: ;--tw-pan-y: ;--tw-pinch-zoom: ;--tw-scroll-snap-strictness:proximity;--tw-gradient-from-position: ;--tw-gradient-via-position: ;--tw-gradient-to-position: ;--tw-ordinal: ;--tw-slashed-zero: ;--tw-numeric-figure: ;--tw-numeric-spacing: ;--tw-numeric-fraction: ;--tw-ring-inset: ;--tw-ring-offset-width:0px;--tw-ring-offset-color:#fff;--tw-ring-color:rgb(59 130 246 / 0.5);--tw-ring-offset-shadow:0 0 #0000;--tw-ring-shadow:0 0 #0000;--tw-shadow:0 0 #0000;--tw-shadow-colored:0 0 #0000;--tw-blur: ;--tw-brightness: ;--tw-contrast: ;--tw-grayscale: ;--tw-hue-rotate: ;--tw-invert: ;--tw-saturate: ;--tw-sepia: ;--tw-drop-shadow: ;--tw-backdrop-blur: ;--tw-backdrop-brightness: ;--tw-backdrop-contrast: ;--tw-backdrop-grayscale: ;--tw-backdrop-hue-rotate: ;--tw-backdrop-invert: ;--tw-backdrop-opacity: ;--tw-backdrop-saturate: ;--tw-backdrop-sepia: ;--tw-contain-size: ;--tw-contain-layout: ;--tw-contain-paint: ;--tw-contain-style: }::backdrop{--tw-border-spacing-x:0;--tw-border-spacing-y:0;--tw-translate-x:0;--tw-translate-y:0;--tw-rotate:0;--tw-skew-x:0;--tw-skew-y:0;--tw-scale-x:1;--tw-scale-y:1;--tw-pan-x: ;--tw-pan-y: ;--tw-pinch-zoom: ;--tw-scroll-snap-strictness:proximity;--tw-gradient-from-position: ;--tw-gradient-via-position: ;--tw-gradient-to-position: ;--tw-ordinal: ;--tw-slashed-zero: ;--tw-numeric-figure: ;--tw-numeric-spacing: ;--tw-numeric-fraction: ;--tw-ring-inset: ;--tw-ring-offset-width:0px;--tw-ring-offset-color:#fff;--tw-ring-color:rgb(59 130 246 / 0.5);--tw-ring-offset-shadow:0 0 #0000;--tw-ring-shadow:0 0 #0000;--tw-shadow:0 0 #0000;--tw-shadow-colored:0 0 #0000;--tw-blur: ;--tw-brightness: ;--tw-contrast: ;--tw-grayscale: ;--tw-hue-rotate: ;--tw-invert: ;--tw-saturate: ;--tw-sepia: ;--tw-drop-shadow: ;--tw-backdrop-blur: ;--tw-backdrop-brightness: ;--tw-backdrop-contrast: ;--tw-backdrop-grayscale: ;--tw-backdrop-hue-rotate: ;--tw-backdrop-invert: ;--tw-backdrop-opacity: ;--tw-backdrop-saturate: ;--tw-backdrop-sepia: ;--tw-contain-size: ;--tw-contain-layout: ;--tw-contain-paint: ;--tw-contain-style: }/* ! tailwindcss v3.4.16 | MIT License | https://tailwindcss.com */*,::after,::before{box-sizing:border-box;border-width:0;border-style:solid;border-color:#e5e7eb}::after,::before{--tw-content:''}:host,html{line-height:1.5;-webkit-text-size-adjust:100%;-moz-tab-size:4;tab-size:4;font-family:ui-sans-serif, system-ui, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";font-feature-settings:normal;font-variation-settings:normal;-webkit-tap-highlight-color:transparent}body{margin:0;line-height:inherit}hr{height:0;color:inherit;border-top-width:1px}abbr:where([title]){-webkit-text-decoration:underline dotted;text-decoration:underline dotted}h1,h2,h3,h4,h5,h6{font-size:inherit;font-weight:inherit}a{color:inherit;text-decoration:inherit}b,strong{font-weight:bolder}code,kbd,pre,samp{font-family:ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;font-feature-settings:normal;font-variation-settings:normal;font-size:1em}small{font-size:80%}sub,sup{font-size:75%;line-height:0;position:relative;vertical-align:baseline}sub{bottom:-.25em}sup{top:-.5em}table{text-indent:0;border-color:inherit;border-collapse:collapse}button,input,optgroup,select,textarea{font-family:inherit;font-feature-settings:inherit;font-variation-settings:inherit;font-size:100%;font-weight:inherit;line-height:inherit;letter-spacing:inherit;color:inherit;margin:0;padding:0}button,select{text-transform:none}button,input:where([type=button]),input:where([type=reset]),input:where([type=submit]){-webkit-appearance:button;background-color:transparent;background-image:none}:-moz-focusring{outline:auto}:-moz-ui-invalid{box-shadow:none}progress{vertical-align:baseline}::-webkit-inner-spin-button,::-webkit-outer-spin-button{height:auto}[type=search]{-webkit-appearance:textfield;outline-offset:-2px}::-webkit-search-decoration{-webkit-appearance:none}::-webkit-file-upload-button{-webkit-appearance:button;font:inherit}summary{display:list-item}blockquote,dd,dl,figure,h1,h2,h3,h4,h5,h6,hr,p,pre{margin:0}fieldset{margin:0;padding:0}legend{padding:0}menu,ol,ul{list-style:none;margin:0;padding:0}dialog{padding:0}textarea{resize:vertical}input::placeholder,textarea::placeholder{opacity:1;color:#9ca3af}[role=button],button{cursor:pointer}:disabled{cursor:default}audio,canvas,embed,iframe,img,object,svg,video{display:block;vertical-align:middle}img,video{max-width:100%;height:auto}[hidden]:where(:not([hidden=until-found])){display:none}.absolute{position:absolute}.relative{position:relative}.bottom-\[25\%\]{bottom:25%}.bottom-\[30\%\]{bottom:30%}.bottom-\[5\%\]{bottom:5%}.left-\[10\%\]{left:10%}.left-\[20\%\]{left:20%}.left-\[25\%\]{left:25%}.left-\[30\%\]{left:30%}.left-\[35\%\]{left:35%}.left-\[65\%\]{left:65%}.right-\[10\%\]{right:10%}.right-\[15\%\]{right:15%}.right-\[20\%\]{right:20%}.right-\[30\%\]{right:30%}.right-\[40\%\]{right:40%}.right-\[5\%\]{right:5%}.top-\[10\%\]{top:10%}.top-\[15\%\]{top:15%}.top-\[20\%\]{top:20%}.top-\[30\%\]{top:30%}.top-\[40\%\]{top:40%}.z-10{z-index:10}.z-20{z-index:20}.mx-auto{margin-left:auto;margin-right:auto}.mb-10{margin-bottom:2.5rem}.mb-6{margin-bottom:1.5rem}.mr-2{margin-right:0.5rem}.mt-8{margin-top:2rem}.flex{display:flex}.hidden{display:none}.h-16{height:4rem}.h-20{height:5rem}.h-6{height:1.5rem}.h-\[200px\]{height:200px}.h-\[25\%\]{height:25%}.h-\[30\%\]{height:30%}.h-\[300px\]{height:300px}.h-\[35\%\]{height:35%}.h-\[40\%\]{height:40%}.h-\[400px\]{height:400px}.h-\[500px\]{height:500px}.h-screen{height:100vh}.w-16{width:4rem}.w-20{width:5rem}.w-6{width:1.5rem}.w-\[200px\]{width:200px}.w-\[300px\]{width:300px}.w-\[400px\]{width:400px}.w-\[500px\]{width:500px}.w-full{width:100%}.w-screen{width:100vw}.max-w-3xl{max-width:48rem}.max-w-4xl{max-width:56rem}.flex-grow{flex-grow:1}.flex-col{flex-direction:column}.items-center{align-items:center}.justify-center{justify-content:center}.justify-between{justify-content:space-between}.gap-3{gap:0.75rem}.gap-6{gap:1.5rem}.space-x-8 > :not([hidden]) ~ :not([hidden]){--tw-space-x-reverse:0;margin-right:calc(2rem * var(--tw-space-x-reverse));margin-left:calc(2rem * calc(1 - var(--tw-space-x-reverse)))}.rounded-full{border-radius:9999px}.rounded-xl{border-radius:0.75rem}.border-2{border-width:2px}.border-white{--tw-border-opacity:1;border-color:rgb(255 255 255 / var(--tw-border-opacity, 1))}.bg-blue-400{--tw-bg-opacity:1;background-color:rgb(96 165 250 / var(--tw-bg-opacity, 1))}.bg-blue-500{--tw-bg-opacity:1;background-color:rgb(59 130 246 / var(--tw-bg-opacity, 1))}.bg-gradient-to-r{background-image:linear-gradient(to right, var(--tw-gradient-stops))}.from-blue-400{--tw-gradient-from:#60a5fa var(--tw-gradient-from-position);--tw-gradient-to:rgb(96 165 250 / 0) var(--tw-gradient-to-position);--tw-gradient-stops:var(--tw-gradient-from), var(--tw-gradient-to)}.from-green-400{--tw-gradient-from:#4ade80 var(--tw-gradient-from-position);--tw-gradient-to:rgb(74 222 128 / 0) var(--tw-gradient-to-position);--tw-gradient-stops:var(--tw-gradient-from), var(--tw-gradient-to)}.to-blue-600{--tw-gradient-to:#2563eb var(--tw-gradient-to-position)}.to-green-600{--tw-gradient-to:#16a34a var(--tw-gradient-to-position)}.px-4{padding-left:1rem;padding-right:1rem}.px-6{padding-left:1.5rem;padding-right:1.5rem}.px-8{padding-left:2rem;padding-right:2rem}.py-2{padding-top:0.5rem;padding-bottom:0.5rem}.py-4{padding-top:1rem;padding-bottom:1rem}.text-left{text-align:left}.text-center{text-align:center}.text-5xl{font-size:3rem;line-height:1}.text-xl{font-size:1.25rem;line-height:1.75rem}.text-xs{font-size:0.75rem;line-height:1rem}.font-bold{font-weight:700}.font-medium{font-weight:500}.font-semibold{font-weight:600}.tracking-tight{letter-spacing:-0.025em}.text-blue-200{--tw-text-opacity:1;color:rgb(191 219 254 / var(--tw-text-opacity, 1))}.text-white{--tw-text-opacity:1;color:rgb(255 255 255 / var(--tw-text-opacity, 1))}.opacity-20{opacity:0.2}.opacity-30{opacity:0.3}.shadow-lg{--tw-shadow:0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);--tw-shadow-colored:0 10px 15px -3px var(--tw-shadow-color), 0 4px 6px -4px var(--tw-shadow-color);box-shadow:var(--tw-ring-offset-shadow, 0 0 #0000), var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow)}.drop-shadow-lg{--tw-drop-shadow:drop-shadow(0 10px 8px rgb(0 0 0 / 0.04)) drop-shadow(0 4px 3px rgb(0 0 0 / 0.1));filter:var(--tw-blur) var(--tw-brightness) var(--tw-contrast) var(--tw-grayscale) var(--tw-hue-rotate) var(--tw-invert) var(--tw-saturate) var(--tw-sepia) var(--tw-drop-shadow)}.transition-all{transition-property:all;transition-timing-function:cubic-bezier(0.4, 0, 0.2, 1);transition-duration:150ms}.hover\:bg-blue-600:hover{--tw-bg-opacity:1;background-color:rgb(37 99 235 / var(--tw-bg-opacity, 1))}@media (min-width: 768px){.md\:flex{display:flex}.md\:hidden{display:none}.md\:flex-row{flex-direction:row}.md\:px-12{padding-left:3rem;padding-right:3rem}.md\:text-2xl{font-size:1.5rem;line-height:2rem}.md\:text-7xl{font-size:4.5rem;line-height:1}}</style><style>
            @keyframes float-up {
                0% {
                    transform: translateY(0) translateX(0);
                    opacity: 0;
                }
                10% {
                    opacity: 1;
                }
                90% {
                    opacity: 1;
                }
                100% {
                    transform: translateY(-100vh) translateX(+6.3121488111752px);
                    opacity: 0;
                }
            }
        </style></head>
<body>
    <div class="lab-background h-screen w-screen flex flex-col relative">
        <!-- Futuristic Lab Background -->
        <div class="futuristic-lab">
            <svg width="100%" height="100%" viewBox="0 0 1200 800" fill="none" xmlns="http://www.w3.org/2000/svg">
                <!-- Dark Background -->
                <rect width="1200" height="800" fill="#0a1128"></rect>
                
                <!-- Lab Floor Grid -->
                <g opacity="0.3">
                    <line x1="0" y1="700" x2="1200" y2="700" stroke="#0095ff" stroke-width="1"></line>
                    <line x1="0" y1="650" x2="1200" y2="650" stroke="#0095ff" stroke-width="0.5"></line>
                    <line x1="0" y1="600" x2="1200" y2="600" stroke="#0095ff" stroke-width="0.5"></line>
                    <line x1="0" y1="550" x2="1200" y2="550" stroke="#0095ff" stroke-width="0.5"></line>
                    <line x1="0" y1="500" x2="1200" y2="500" stroke="#0095ff" stroke-width="0.5"></line>
                    
                    <line x1="100" y1="500" x2="100" y2="700" stroke="#0095ff" stroke-width="0.5"></line>
                    <line x1="200" y1="500" x2="200" y2="700" stroke="#0095ff" stroke-width="0.5"></line>
                    <line x1="300" y1="500" x2="300" y2="700" stroke="#0095ff" stroke-width="0.5"></line>
                    <line x1="400" y1="500" x2="400" y2="700" stroke="#0095ff" stroke-width="0.5"></line>
                    <line x1="500" y1="500" x2="500" y2="700" stroke="#0095ff" stroke-width="0.5"></line>
                    <line x1="600" y1="500" x2="600" y2="700" stroke="#0095ff" stroke-width="0.5"></line>
                    <line x1="700" y1="500" x2="700" y2="700" stroke="#0095ff" stroke-width="0.5"></line>
                    <line x1="800" y1="500" x2="800" y2="700" stroke="#0095ff" stroke-width="0.5"></line>
                    <line x1="900" y1="500" x2="900" y2="700" stroke="#0095ff" stroke-width="0.5"></line>
                    <line x1="1000" y1="500" x2="1000" y2="700" stroke="#0095ff" stroke-width="0.5"></line>
                    <line x1="1100" y1="500" x2="1100" y2="700" stroke="#0095ff" stroke-width="0.5"></line>
                </g>
                
                <!-- Lab Walls -->
                <rect x="50" y="100" width="1100" height="400" fill="#0a1128" stroke="#0095ff" stroke-width="1" opacity="0.7"></rect>
                
                <!-- Lab Windows -->
                <rect x="100" y="150" width="200" height="150" fill="#0a1128" stroke="#0095ff" stroke-width="1" opacity="0.8"></rect>
                <rect x="350" y="150" width="200" height="150" fill="#0a1128" stroke="#0095ff" stroke-width="1" opacity="0.8"></rect>
                <rect x="600" y="150" width="200" height="150" fill="#0a1128" stroke="#0095ff" stroke-width="1" opacity="0.8"></rect>
                <rect x="850" y="150" width="200" height="150" fill="#0a1128" stroke="#0095ff" stroke-width="1" opacity="0.8"></rect>
                
                <!-- Lab Equipment -->
                <rect x="150" y="350" width="100" height="150" fill="#0a1128" stroke="#0095ff" stroke-width="1"></rect>
                <rect x="400" y="350" width="150" height="150" fill="#0a1128" stroke="#0095ff" stroke-width="1"></rect>
                <rect x="700" y="350" width="120" height="150" fill="#0a1128" stroke="#0095ff" stroke-width="1"></rect>
                <rect x="900" y="350" width="100" height="150" fill="#0a1128" stroke="#0095ff" stroke-width="1"></rect>
                
                <!-- Ceiling Lights -->
                <rect x="200" y="120" width="50" height="10" fill="#0095ff" opacity="0.8"></rect>
                <rect x="450" y="120" width="50" height="10" fill="#0095ff" opacity="0.8"></rect>
                <rect x="700" y="120" width="50" height="10" fill="#0095ff" opacity="0.8"></rect>
                <rect x="950" y="120" width="50" height="10" fill="#0095ff" opacity="0.8"></rect>
                
                <!-- Holographic Displays -->
                <circle cx="200" y="400" r="30" fill="none" stroke="#0095ff" stroke-width="1" opacity="0.6"></circle>
                <circle cx="475" y="400" r="40" fill="none" stroke="#0095ff" stroke-width="1" opacity="0.6"></circle>
                <circle cx="760" y="400" r="35" fill="none" stroke="#0095ff" stroke-width="1" opacity="0.6"></circle>
                <circle cx="950" y="400" r="25" fill="none" stroke="#0095ff" stroke-width="1" opacity="0.6"></circle>
                
                <!-- DNA Helix -->
                <path d="M950 200 Q970 225 950 250 Q930 275 950 300 Q970 325 950 350" stroke="#0095ff" stroke-width="1" fill="none"></path>
                <path d="M970 200 Q950 225 970 250 Q990 275 970 300 Q950 325 970 350" stroke="#0095ff" stroke-width="1" fill="none"></path>
                
                <!-- Connecting Lines -->
                <line x1="950" y1="210" x2="970" y2="210" stroke="#0095ff" stroke-width="0.5"></line>
                <line x1="950" y1="230" x2="970" y2="230" stroke="#0095ff" stroke-width="0.5"></line>
                <line x1="950" y1="250" x2="970" y2="250" stroke="#0095ff" stroke-width="0.5"></line>
                <line x1="950" y1="270" x2="970" y2="270" stroke="#0095ff" stroke-width="0.5"></line>
                <line x1="950" y1="290" x2="970" y2="290" stroke="#0095ff" stroke-width="0.5"></line>
                <line x1="950" y1="310" x2="970" y2="310" stroke="#0095ff" stroke-width="0.5"></line>
                <line x1="950" y1="330" x2="970" y2="330" stroke="#0095ff" stroke-width="0.5"></line>
                
                <!-- Medical Symbols -->
                <path d="M200 220 L200 280 M170 250 L230 250" stroke="#0095ff" stroke-width="2"></path>
                <circle cx="475" cy="250" r="30" fill="none" stroke="#0095ff" stroke-width="2"></circle>
                <path d="M475 220 L475 280" stroke="#0095ff" stroke-width="2"></path>
                <path d="M445 250 L505 250" stroke="#0095ff" stroke-width="2"></path>
                
                <!-- Brain Scan -->
                <ellipse cx="700" cy="250" rx="35" ry="30" fill="none" stroke="#0095ff" stroke-width="1"></ellipse>
                <path d="M680 235 Q700 220 720 235 Q730 250 720 265 Q700 280 680 265 Q670 250 680 235" fill="none" stroke="#0095ff" stroke-width="1"></path>
                <path d="M685 240 Q700 230 715 240" fill="none" stroke="#0095ff" stroke-width="0.5"></path>
                <path d="M685 260 Q700 270 715 260" fill="none" stroke="#0095ff" stroke-width="0.5"></path>
                <path d="M700 230 L700 270" fill="none" stroke="#0095ff" stroke-width="0.5"></path>
            </svg>
        </div>
        
        <!-- Overlay -->
        <div class="overlay"></div>
        
        <!-- Scanner Line -->
        <div class="scanner-line"></div>
        
        <!-- Digital Circles -->
        <div class="digital-circle w-[300px] h-[300px] top-[30%] left-[20%]"></div>
        <div class="digital-circle w-[200px] h-[200px] top-[40%] right-[30%]" style="animation-delay: -5s;"></div>
        <div class="digital-circle w-[400px] h-[400px] top-[20%] right-[10%]" style="animation-delay: -10s;"></div>
        
        <!-- Circle Decorations -->
        <div class="circle-decoration w-[300px] h-[300px] top-[10%] left-[10%]"></div>
        <div class="circle-decoration w-[500px] h-[500px] bottom-[5%] right-[5%]" style="animation-delay: -3s;"></div>
        <div class="circle-decoration w-[200px] h-[200px] top-[30%] right-[20%]" style="animation-delay: -6s;"></div>
        
        <!-- Holograms -->
        <div class="hologram top-[20%] right-[40%]"></div>
        <div class="hologram top-[40%] left-[30%]"></div>
        
        <!-- Data Streams -->
        <div class="data-stream h-[30%] top-[10%] left-[35%]"></div>
        <div class="data-stream h-[40%] top-[20%] left-[65%]"></div>
        <div class="data-stream h-[25%] top-[40%] left-[25%]"></div>
        <div class="data-stream h-[35%] top-[30%] right-[15%]"></div>
        
        <!-- Floating Lab Equipment -->
        <div class="lab-equipment bottom-[30%] right-[20%] floating" style="animation-delay: -1s;">
            <svg width="120" height="120" viewBox="0 0 120 120" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M40 20H80L70 60H50L40 20Z" stroke="#0095ff" stroke-width="2" fill="rgba(0,149,255,0.1)"></path>
                <path d="M50 60V90C50 95 60 95 60 90V60" stroke="#0095ff" stroke-width="2"></path>
                <circle cx="60" cy="100" r="10" stroke="#0095ff" stroke-width="2" fill="rgba(0,149,255,0.1)"></circle>
            </svg>
        </div>
        
        <!-- Modern Tech Elements -->
        <div class="absolute top-[15%] right-[15%] w-20 h-20 hexagon bg-blue-400 opacity-30 floating" style="animation-delay: -2s;"></div>
        <div class="absolute bottom-[25%] left-[10%] w-16 h-16 hexagon bg-blue-500 opacity-20 floating" style="animation-delay: -4s;"></div>
        
        <!-- Particles -->
        <div class="particles" id="particles"><div class="particle" style="width: 5.10045px; height: 5.10045px; left: 63.4043%; top: 64.4015%; animation-duration: 18.9497s; animation-delay: 3.77442s;"></div><div class="particle" style="width: 3.81407px; height: 3.81407px; left: 5.48304%; top: 95.9228%; animation-duration: 16.3173s; animation-delay: 1.70767s;"></div><div class="particle" style="width: 5.82223px; height: 5.82223px; left: 42.8903%; top: 65.8082%; animation-duration: 18.9291s; animation-delay: 7.71175s;"></div><div class="particle" style="width: 5.56028px; height: 5.56028px; left: 51.3079%; top: 32.2882%; animation-duration: 18.4803s; animation-delay: 6.12096s;"></div><div class="particle" style="width: 2.11896px; height: 2.11896px; left: 79.7391%; top: 58.2667%; animation-duration: 15.8021s; animation-delay: 4.18869s;"></div><div class="particle" style="width: 5.43928px; height: 5.43928px; left: 60.6023%; top: 27.0123%; animation-duration: 16.2067s; animation-delay: 9.68832s;"></div><div class="particle" style="width: 5.01337px; height: 5.01337px; left: 9.97821%; top: 81.9689%; animation-duration: 17.7072s; animation-delay: 3.58541s;"></div><div class="particle" style="width: 3.06863px; height: 3.06863px; left: 3.69728%; top: 14.1646%; animation-duration: 19.137s; animation-delay: 7.34255s;"></div><div class="particle" style="width: 5.96636px; height: 5.96636px; left: 59.8722%; top: 20.9024%; animation-duration: 18.5802s; animation-delay: 9.52155s;"></div><div class="particle" style="width: 4.66465px; height: 4.66465px; left: 49.7293%; top: 6.09847%; animation-duration: 10.8939s; animation-delay: 7.29114s;"></div><div class="particle" style="width: 5.12732px; height: 5.12732px; left: 10.2823%; top: 9.65645%; animation-duration: 18.277s; animation-delay: 0.357592s;"></div><div class="particle" style="width: 4.69192px; height: 4.69192px; left: 85.7629%; top: 26.137%; animation-duration: 11.1579s; animation-delay: 3.90856s;"></div><div class="particle" style="width: 2.36553px; height: 2.36553px; left: 97.7485%; top: 35.6875%; animation-duration: 16.6378s; animation-delay: 7.15562s;"></div><div class="particle" style="width: 5.0253px; height: 5.0253px; left: 48.9555%; top: 70.4795%; animation-duration: 18.8568s; animation-delay: 9.78225s;"></div><div class="particle" style="width: 3.9825px; height: 3.9825px; left: 41.0914%; top: 23.8323%; animation-duration: 11.8096s; animation-delay: 8.73961s;"></div><div class="particle" style="width: 2.93257px; height: 2.93257px; left: 58.3156%; top: 47.4049%; animation-duration: 14.5104s; animation-delay: 0.457702s;"></div><div class="particle" style="width: 3.037px; height: 3.037px; left: 33.1038%; top: 60.3956%; animation-duration: 13.8942s; animation-delay: 9.63776s;"></div><div class="particle" style="width: 5.40932px; height: 5.40932px; left: 97.4541%; top: 20.9249%; animation-duration: 10.694s; animation-delay: 8.45982s;"></div><div class="particle" style="width: 3.37583px; height: 3.37583px; left: 7.79334%; top: 45.3231%; animation-duration: 16.9936s; animation-delay: 1.63031s;"></div><div class="particle" style="width: 3.05708px; height: 3.05708px; left: 68.7794%; top: 97.3182%; animation-duration: 15.083s; animation-delay: 7.43327s;"></div><div class="particle" style="width: 2.36727px; height: 2.36727px; left: 62.8804%; top: 70.4149%; animation-duration: 19.8531s; animation-delay: 9.09036s;"></div><div class="particle" style="width: 5.02185px; height: 5.02185px; left: 53.7435%; top: 68.679%; animation-duration: 13.5789s; animation-delay: 2.70416s;"></div><div class="particle" style="width: 5.91954px; height: 5.91954px; left: 84.8076%; top: 84.307%; animation-duration: 19.071s; animation-delay: 5.97623s;"></div><div class="particle" style="width: 4.62713px; height: 4.62713px; left: 18.9542%; top: 57.1553%; animation-duration: 17.031s; animation-delay: 5.98763s;"></div><div class="particle" style="width: 2.78341px; height: 2.78341px; left: 13.2608%; top: 28.9375%; animation-duration: 10.1689s; animation-delay: 2.75826s;"></div><div class="particle" style="width: 3.86064px; height: 3.86064px; left: 85.2514%; top: 92.6555%; animation-duration: 18.2271s; animation-delay: 7.74069s;"></div><div class="particle" style="width: 4.19522px; height: 4.19522px; left: 43.3727%; top: 88.5149%; animation-duration: 18.5588s; animation-delay: 1.37958s;"></div><div class="particle" style="width: 4.2189px; height: 4.2189px; left: 21.2601%; top: 9.39439%; animation-duration: 12.0742s; animation-delay: 8.08809s;"></div><div class="particle" style="width: 2.78825px; height: 2.78825px; left: 12.842%; top: 42.7182%; animation-duration: 15.2423s; animation-delay: 5.44069s;"></div><div class="particle" style="width: 5.48555px; height: 5.48555px; left: 75.1809%; top: 37.1136%; animation-duration: 13.2074s; animation-delay: 8.86853s;"></div></div>
        
        <!-- Navigation Bar -->
        <header class="w-full py-4 px-6 md:px-12 flex justify-between items-center z-20">
            <!-- Logo -->
            <div class="flex items-center">
                <svg width="40" height="40" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg" class="mr-2">
                    <circle cx="20" cy="20" r="18" fill="#0095ff"></circle>
                    <path d="M12 20C12 15.5817 15.5817 12 20 12C24.4183 12 28 15.5817 28 20C28 24.4183 24.4183 28 20 28C15.5817 28 12 24.4183 12 20Z" fill="white"></path>
                    <path d="M20 14V26" stroke="#0095ff" stroke-width="2" stroke-linecap="round"></path>
                    <path d="M14 20H26" stroke="#0095ff" stroke-width="2" stroke-linecap="round"></path>
                    <path d="M16 16L24 24" stroke="#0095ff" stroke-width="1.5" stroke-linecap="round"></path>
                    <path d="M16 24L24 16" stroke="#0095ff" stroke-width="1.5" stroke-linecap="round"></path>
                </svg>
                <span class="text-xl font-bold text-white">Doctor AI</span>
            </div>
            
            <!-- Navigation Links -->
            <nav class="hidden md:flex items-center space-x-8">
                <a href="#" class="nav-link active text-white font-medium">Home</a>
                <a href="#" class="nav-link text-white font-medium">About Us</a>
                <a href="#" class="bg-blue-500 hover:bg-blue-600 text-white px-6 py-2 rounded-full transition-all">Contact</a>
            </nav>
            
            <!-- Mobile Menu Button -->
            <button class="md:hidden text-white">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
                </svg>
            </button>
        </header>
        
        <!-- Content -->
        <div class="flex-grow flex items-center justify-center z-10">
            <div class="text-center px-4 max-w-4xl">
                <h1 class="text-5xl md:text-7xl font-bold text-white mb-6 tracking-tight drop-shadow-lg">Doctor AI</h1>
                <p class="text-xl md:text-2xl text-blue-200 mb-10 max-w-3xl mx-auto font-medium">Advanced medical assistance powered by artificial intelligence</p>
                
                <div class="flex flex-col md:flex-row justify-center gap-6 mt-8">
                    <a href="#" class="download-btn bg-gradient-to-r from-green-400 to-green-600 text-white flex items-center justify-center gap-3 px-8 py-4 rounded-xl border-2 border-white shadow-lg">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                            <path d="M17.9 5c-.1.1-.2.3-.2.4v13.1c0 .2.1.3.2.4l5.2-7-5.2-6.9zM3 4.3l7.1 6.5-7.1 6.5V4.3zm9.5 6.8l2.4-2.4c.3-.3.6-.4 1-.4s.7.1 1 .4l2.4 2.4 5.4-5.4c-.4-.7-1.1-1.2-1.9-1.2H9.1c-.8 0-1.5.5-1.9 1.2l5.3 5.4zm0 1.3L9.9 14.9c-.3.3-.6.4-1 .4s-.7-.1-1-.4L5.5 12.4l-3.2 3.2c.4.7 1.1 1.2 1.9 1.2h14.7c.8 0 1.5-.5 1.9-1.2l-3.2-3.2-2.4 2.4c-.3.3-.6.4-1 .4s-.7-.1-1-.4l-2.6-2.4z"></path>
                        </svg>
                        <div class="text-left">
                            <div class="text-xs">GET IT ON</div>
                            <div class="text-xl font-semibold">Google Play</div>
                        </div>
                    </a>
                    
                    <a href="#" class="download-btn bg-gradient-to-r from-blue-400 to-blue-600 text-white flex items-center justify-center gap-3 px-8 py-4 rounded-xl border-2 border-white shadow-lg">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                            <path d="M16.5 3c1.4 1.1 2.4 2.6 2.5 4.1-1.4.8-2.5 2.2-2.5 3.9 0 1.7 1 3.1 2.5 3.9-.2 1.5-1.1 3-2.5 4.1-1.1.8-2.1 1-3.4 1-.5 0-1-.1-1.6-.2-.5-.1-1-.2-1.5-.2s-1 .1-1.5.2c-.6.1-1.1.2-1.6.2-1.3 0-2.3-.2-3.4-1-1.4-1.1-2.4-2.6-2.5-4.1 1.4-.8 2.5-2.2 2.5-3.9 0-1.7-1-3.1-2.5-3.9.1-1.5 1.1-3 2.5-4.1 1.1-.8 2.1-1 3.4-1 .5 0 1 .1 1.6.2.5.1 1 .2 1.5.2s1-.1 1.5-.2c.6-.1 1.1-.2 1.6-.2 1.3 0 2.3.2 3.4 1zm-4.5 15c1.1 0 2.5-1.9 3.5-5-1.1 0-2.5 1.9-3.5 5zm-4 0c1-3.1 2.4-5 3.5-5-1 3.1-2.4 5-3.5 5zm10.5-14c-.8.7-1.5 1.9-1.5 3s.7 2.3 1.5 3c-.8-.7-1.5-1.9-1.5-3s.7-2.3 1.5-3zm-17 0c.8.7 1.5 1.9 1.5 3s-.7 2.3-1.5 3c.8-.7 1.5-1.9 1.5-3s-.7-2.3-1.5-3zm12.5-1c-1.1 0-2.5 1.9-3.5 5 1.1 0 2.5-1.9 3.5-5zm-8 0c1 3.1 2.4 5 3.5 5-1-3.1-2.4-5-3.5-5z"></path>
                        </svg>
                        <div class="text-left">
                            <div class="text-xs">Download on the</div>
                            <div class="text-xl font-semibold">App Store</div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Create floating particles
        const particlesContainer = document.getElementById('particles');
        const particleCount = 30;
        
        for (let i = 0; i < particleCount; i++) {
            const particle = document.createElement('div');
            particle.classList.add('particle');
            
            // Random size between 2-6px
            const size = Math.random() * 4 + 2;
            particle.style.width = `${size}px`;
            particle.style.height = `${size}px`;
            
            // Random position
            particle.style.left = `${Math.random() * 100}%`;
            particle.style.top = `${Math.random() * 100}%`;
            
            // Random animation duration between 10-20s
            const duration = Math.random() * 10 + 10;
            particle.style.animationDuration = `${duration}s`;
            
            // Random delay
            particle.style.animationDelay = `${Math.random() * 10}s`;
            
            particlesContainer.appendChild(particle);
        }
        
        // Add floating animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes float-up {
                0% {
                    transform: translateY(0) translateX(0);
                    opacity: 0;
                }
                10% {
                    opacity: 1;
                }
                90% {
                    opacity: 1;
                }
                100% {
                    transform: translateY(-100vh) translateX(${Math.random() > 0.5 ? '+' : '-'}${Math.random() * 100}px);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
    </script>
<script>(function(){function c(){var b=a.contentDocument||a.contentWindow.document;if(b){var d=b.createElement('script');d.innerHTML="window.__CF$cv$params={r:'94dd790106143fdb',t:'MTc0OTYwNjc4NC4wMDAwMDA='};var a=document.createElement('script');a.nonce='';a.src='/cdn-cgi/challenge-platform/scripts/jsd/main.js';document.getElementsByTagName('head')[0].appendChild(a);";b.getElementsByTagName('head')[0].appendChild(d)}}if(document.body){var a=document.createElement('iframe');a.height=1;a.width=1;a.style.position='absolute';a.style.top=0;a.style.left=0;a.style.border='none';a.style.visibility='hidden';document.body.appendChild(a);if('loading'!==document.readyState)c();else if(window.addEventListener)document.addEventListener('DOMContentLoaded',c);else{var e=document.onreadystatechange||function(){};document.onreadystatechange=function(b){e(b);'loading'!==document.readyState&&(document.onreadystatechange=e,c())}}}})();</script><iframe height="1" width="1" style="position: absolute; top: 0px; left: 0px; border: none; visibility: hidden;"></iframe>

</body></html>