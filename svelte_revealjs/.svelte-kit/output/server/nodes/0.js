

export const index = 0;
let component_cache;
export const component = async () => component_cache ??= (await import('../entries/pages/_layout.svelte.js')).default;
export const imports = ["_app/immutable/nodes/0.d2565f77.js","_app/immutable/chunks/scheduler.e108d1fd.js","_app/immutable/chunks/index.7255a256.js"];
export const stylesheets = ["_app/immutable/assets/0.31d16134.css"];
export const fonts = [];
