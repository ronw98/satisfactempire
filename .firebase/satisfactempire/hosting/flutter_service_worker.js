'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"404.html": "0a27a4163254fc8fce870c8cc3a3f94f",
"assets/AssetManifest.bin": "c5ae7fadc923859e3186b8864669e8a7",
"assets/AssetManifest.bin.json": "f57218836172b310d31efc33e072be5a",
"assets/AssetManifest.json": "bf76484b029e0c33446be5ea2427fbe7",
"assets/assets/items/Adaptive_Control_Unit.webp": "84645dd7f9b073d66520aaac8ccca859",
"assets/assets/items/AI_Limiter.webp": "a641461bd028acdbdde6718c9920c530",
"assets/assets/items/Alclad_Aluminum_Sheet.webp": "adfed358e2603a8f8aa34277c6c9523f",
"assets/assets/items/Alumina_Solution.webp": "cb09d25c4b353bff369f2b6ac0127889",
"assets/assets/items/Aluminum_Casing.webp": "e4b2585a9f1546bf4c9f7e9ee69cdc04",
"assets/assets/items/Aluminum_Ingot.webp": "b7cd67860ff345c6482490845bb253a5",
"assets/assets/items/Aluminum_Scrap.webp": "e65351ddff511db44dc97fc09e518c54",
"assets/assets/items/Assembly_Director_System.webp": "e98d1dbe9577ebd69054aac119b6ed9e",
"assets/assets/items/Automated_Wiring.webp": "b7d3c655975803000db128b9d5d8819d",
"assets/assets/items/Battery.webp": "df239d1f14ff7870b91f7b38088c3480",
"assets/assets/items/Bauxite.webp": "5d7a27d4c9b0cfc2f912b5cec6377ce7",
"assets/assets/items/Black_Powder.webp": "6b34e6689722db6389e90f161bf236c7",
"assets/assets/items/Cable.webp": "5fe1f2f83a883c7cda45523a1318b1c5",
"assets/assets/items/Caterium_Ingot.webp": "da0b61621c94a300ba5d6371fb36eaa2",
"assets/assets/items/Caterium_Ore.webp": "eff71b6148b965311543fe95838ef3af",
"assets/assets/items/Circuit_Board.webp": "bf8692fef7fcdda29498c764859dfecd",
"assets/assets/items/Coal.webp": "fc6f22be84565d76b2484e046a354af0",
"assets/assets/items/Compacted_Coal.webp": "492653c9ca6f29424a6773e8bcd10868",
"assets/assets/items/Computer.webp": "0a543a9fe4495875e0cef0286bd5321f",
"assets/assets/items/Concrete.webp": "fb39f82c0881eb9178e6fd9e11a42d91",
"assets/assets/items/Cooling_System.webp": "703e7250db83f3c4b76672d86eebfe85",
"assets/assets/items/Copper_Ingot.webp": "a784d3bd7a0cfb15b8ed853764d7abde",
"assets/assets/items/Copper_Ore.webp": "f27190c5efdd3868f0a80d0f28946c9a",
"assets/assets/items/Copper_Powder.webp": "e491e66c7e4062a63843dce991552f8d",
"assets/assets/items/Copper_Sheet.webp": "5c13ad9ba83e9d1f2a5129ac8f39f335",
"assets/assets/items/Crude_Oil.webp": "6e5cbfe41ea3ae4422cf091b9ee82244",
"assets/assets/items/Crystal_Oscillator.webp": "04b90bfdbbea9bd2447a2ff433dae524",
"assets/assets/items/Electromagnetic_Control_Rod.webp": "93f5c17aa29a8dfa2df40d242d4b5fe2",
"assets/assets/items/Empty_Canister.webp": "7793c8573de400339ad3c376801fd1ea",
"assets/assets/items/Empty_Fluid_Tank.webp": "ba7ab1780d65c4f348ddb3e4ef3e033e",
"assets/assets/items/Encased_Industrial_Beam.webp": "ef3889d97c9ff25db44565687208d057",
"assets/assets/items/Encased_Plutonium_Cell.webp": "a488e830af3808dd213dcf7d7cf7043c",
"assets/assets/items/Encased_Uranium_Cell.webp": "1f1fe9869eed1aa3293019cb5d38a944",
"assets/assets/items/Fabric.webp": "bf10a3bce50a9fcb60b8c395ab96ff89",
"assets/assets/items/Fuel.webp": "e4cfc9e4d4ee11d5d42ee9dc41dfd541",
"assets/assets/items/Fused_Modular_Frame.webp": "dc7b13a694a03c016eea03921f953338",
"assets/assets/items/Gas_Filter.webp": "c24ebcb03211607216ad560dcc8879dd",
"assets/assets/items/Heat_Sink.webp": "5d836d7e288304336375e9665eceea90",
"assets/assets/items/Heavy_Modular_Frame.webp": "d01eef7646edfc605f2313f6c17af7a5",
"assets/assets/items/Heavy_Oil_Residue.webp": "b945777db263bf09fef7edb0ae895ee8",
"assets/assets/items/High-Speed_Connector.webp": "b1d402c9eab4db0cb65728db76c40e83",
"assets/assets/items/Iodine_Infused_Filter.webp": "af1d7e238f42c1051d7615b117de3e86",
"assets/assets/items/Iron_Ingot.webp": "59738478ce0f21c659b79b38a41f80d9",
"assets/assets/items/Iron_Ore.webp": "c8980db15fb62d34f6cdbbd99aad83ff",
"assets/assets/items/Iron_Plate.webp": "757216bd1d95a28810eb6cd9e1affd9b",
"assets/assets/items/Iron_Rod.webp": "70d537c6c71003ac078c6999f06464e8",
"assets/assets/items/Limestone.webp": "59a4554809e8ee650283eb72dca4eead",
"assets/assets/items/Liquid_Biofuel.webp": "ad0e4a774137a6813e6274ff68c0e6ce",
"assets/assets/items/Magnetic_Field_Generator.webp": "dc4f094a78fef15c83d6bfbfd772a7cb",
"assets/assets/items/Modular_Engine.webp": "f6c1cd525e7e5b7c1a7e3ea68a790823",
"assets/assets/items/Modular_Frame.webp": "938b2470000c1b8c7e852c1f04bd2f57",
"assets/assets/items/Motor.webp": "cc72a092302daa611a901fbefd00ba63",
"assets/assets/items/Nitric_Acid.webp": "44aef7d91a5afad500139308ad3b1f62",
"assets/assets/items/Nitrogen_Gas.webp": "f73c3014027a99bf64c0fafc0fd92035",
"assets/assets/items/Non-fissile_Uranium.webp": "d8dcae05f0e42f3be07191b1fe7ccd3f",
"assets/assets/items/Nuclear_Pasta.webp": "eaa41b6fabaf2241a45113da5393aada",
"assets/assets/items/Packaged_Alumina_Solution.webp": "d5450abcf88010115f8bf252cd53ed13",
"assets/assets/items/Packaged_Fuel.webp": "0250e51c7ee18f93d9c5962fdef9f7fa",
"assets/assets/items/Packaged_Heavy_Oil_Residue.webp": "deb5566335d264164ba9e1cc0fa8fea3",
"assets/assets/items/Packaged_Liquid_Biofuel.webp": "86d10fa00314a1ad0e0a245602bee5ec",
"assets/assets/items/Packaged_Nitric_Acid.webp": "bcad9fb9585bc4da9d7fb7b0d7d867fe",
"assets/assets/items/packaged_nitrogen_gas.webp": "351db58ec658b8ba931bcd6891b7ca98",
"assets/assets/items/Packaged_Oil.webp": "245e4a23778e3c2a216912e629a6edb8",
"assets/assets/items/Packaged_Sulfuric_Acid.webp": "1a81d3f596372ee18b05fb6245cfab9f",
"assets/assets/items/Packaged_Turbofuel.webp": "dfaf1540d5bef14436f402619d0650c1",
"assets/assets/items/Packaged_Water.webp": "cfdeb17e8c2e8969cfd0f90bfe929934",
"assets/assets/items/Petroleum_Coke.webp": "a7a499660fad4f2d82188b303150dcab",
"assets/assets/items/Plastic.webp": "517bb06c8a978877d39efb9551c37608",
"assets/assets/items/Plutonium_Fuel_Rod.webp": "61132518764d361514478f0e17b34fb3",
"assets/assets/items/Plutonium_Pellet.webp": "324365eb21d4fa9091f07e8d6d27a4b7",
"assets/assets/items/Plutonium_Waste.webp": "30be3dbf30fc2e64e94db211653764eb",
"assets/assets/items/Polymer_Resin.webp": "4313f5fa3b022c9e6cdc4c94286aeae0",
"assets/assets/items/Pressure_Conversion_Cube.webp": "d00378bdd527e8e664a408ecbbea8bd1",
"assets/assets/items/Quantum_Computer.webp": "f6684bc64e556ff63f1c7daf8dffe390",
"assets/assets/items/Quartz_Crystal.webp": "7d8f06e7735920e7d1428c23bdb4392e",
"assets/assets/items/Quickwire.webp": "32a6289756eaa5e433ed07fe00ed8dc6",
"assets/assets/items/Radio_Control_Unit.webp": "505f4189ca4f4f268de6e5ea8077bd21",
"assets/assets/items/Raw_Quartz.webp": "6bafe68c4eabb37b1fabb765292549c5",
"assets/assets/items/Reinforced_Iron_Plate.webp": "7c701d2a3639461fea8f40c6503e9d98",
"assets/assets/items/rien.png": "075d7851c134bc18be7d795253ed3a99",
"assets/assets/items/Rotor.webp": "29835ec0f13fd03b9b99f0539d4f522a",
"assets/assets/items/Rubber.webp": "9d4f7703e7cd841816f378abb05c1242",
"assets/assets/items/SAM.webp": "aa973d4c0ab6876f8a81a1fdca1e5ff0",
"assets/assets/items/Screw.webp": "d449abe1743cd97b3e0191bd485aa72c",
"assets/assets/items/Silica.webp": "8848ae30d5502e2319b03352649658cc",
"assets/assets/items/Smart_Plating.webp": "31c420c056a642da06a8d9dc09d3d55b",
"assets/assets/items/Smokeless_Powder.webp": "94af14ed86b575c8a75febc029485fa9",
"assets/assets/items/Stator.webp": "6ab43df24da0e88b6ac010a9a28af171",
"assets/assets/items/Steel_Beam.webp": "c69033356deeae60579da99c08cfbde2",
"assets/assets/items/Steel_Ingot.webp": "4ce0afad8f5d17ade8211f33420bd8a2",
"assets/assets/items/Steel_Pipe.webp": "a735a42863ef6ff1d6540dbd122e074b",
"assets/assets/items/Sulfur.webp": "bf18a061ec9881b46fcd4e3e0fa45089",
"assets/assets/items/Sulfuric_Acid.webp": "5d40f0003acde13123a26f6bbbe9a3d8",
"assets/assets/items/Supercomputer.webp": "3fbc2bd9e12d46d26af1cd536f77fb37",
"assets/assets/items/Superposition_Oscillator.webp": "665a3e84bb4a01201561c70a53207e67",
"assets/assets/items/Thermal_Propulsion_Rocket.webp": "9f59bd63eed55ed522200a7d4a6ef376",
"assets/assets/items/Turbofuel.webp": "d073a3a4d36e9fbaeb7637e47699bddf",
"assets/assets/items/Turbo_Motor.webp": "62372e665c72763cce40bdd258f3d939",
"assets/assets/items/Uranium.webp": "a251eb7a7d3c0fa52e4564b5f2b66502",
"assets/assets/items/Uranium_Fuel_Rod.webp": "4b005a6467ba84918e1a6714fa18d78a",
"assets/assets/items/Uranium_Pellet.webp": "8971e0a60ab8686c77368fbba8c997c5",
"assets/assets/items/Uranium_Waste.webp": "838563caf7ee0ade6500f5d76b485db7",
"assets/assets/items/Versatile_Framework.webp": "31cff7daf7b8dec753c53e0adb5c130a",
"assets/assets/items/Water.webp": "16d6d5857ab2a1fd1441f48a2557dae6",
"assets/assets/items/Wire.webp": "edec0774c6a058070a553dfb39ff4327",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "10c7c108c2514970972c09c96c5b5134",
"assets/NOTICES": "b3d5f74312ac1e75a68678a3aef21c84",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "74d0970aa083f091dd61bef3a2da2676",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "d25a1b7e9b78b0f67d1dfc186b242d6e",
"index.html": "edcacbd4d571cf3ad635bdcf0ade5536",
"/": "edcacbd4d571cf3ad635bdcf0ade5536",
"main.dart.js": "9d2acceab704f4e18486766d8663a14f",
"manifest.json": "5d2573727f7a138e3c760654cfa7c3b5",
"version.json": "b60d846bbfec7e143b387bc6f8724bcd"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
