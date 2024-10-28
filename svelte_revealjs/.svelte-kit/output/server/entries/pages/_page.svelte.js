import { c as create_ssr_component, a as subscribe, e as each } from "../../chunks/ssr.js";
import "reveal.js";
import "reveal.js/plugin/markdown/markdown.js";
import { w as writable } from "../../chunks/index.js";
import { e as escape } from "../../chunks/escape.js";
const reveal = "";
const black = "";
const userName = writable("world");
const Page = create_ssr_component(($$result, $$props, $$bindings, slots) => {
  let $userName, $$unsubscribe_userName;
  $$unsubscribe_userName = subscribe(userName, (value) => $userName = value);
  let { partner = ["Svelte", "Reveal", "Tailwind"] } = $$props;
  const sections = {
    "Title 1": "paragraph",
    "Title 2": "paragraph",
    "Title 3": "paragraph",
    "Title 4": "paragraph",
    "Title 5": "paragraph"
  };
  if ($$props.partner === void 0 && $$bindings.partner && partner !== void 0)
    $$bindings.partner(partner);
  $$unsubscribe_userName();
  return `<div class="reveal"><div class="slides"><section><h2>${escape(partner.join(" + "))} = <span class="heart" data-svelte-h="svelte-o8acmx">❤</span></h2> <p class="text-pink-300" data-svelte-h="svelte-1ksetrn">Lets have fun!</p></section> <section data-svelte-h="svelte-7lzpih"><h2>Slide 2</h2></section> <section><h2 data-svelte-h="svelte-j18sz5">User input</h2> <form method="POST"><div class="relative mb-6" data-te-input-wrapper-init data-svelte-h="svelte-n6kydp"><input type="text" class="peer block min-h-[auto] w-full rounded bg-transparent text-lg px-3 py-[0.32rem] leading-[2.15] outline-none transition-all duration-200 ease-linear focus:placeholder:opacity-100 data-[te-input-state-active]:placeholder:opacity-100 motion-reduce:transition-none dark:text-neutral-800 dark:placeholder:text-neutral-200 [&amp;:not([data-te-input-placeholder-active])]:placeholder:opacity-0" id="nameField" name="name" placeholder="Full name"> <label for="nameField" class="pointer-events-none absolute left-3 top-0 mb-0 max-w-[90%] origin-[0_0] truncate pt-[0.37rem] leading-[2.15] text-neutral-500 transition-all duration-200 ease-out peer-focus:-translate-y-[1.15rem] peer-focus:scale-[0.8] peer-focus:text-primary peer-data-[te-input-state-active]:-translate-y-[1.15rem] peer-data-[te-input-state-active]:scale-[0.8] motion-reduce:transition-none dark:text-neutral-400 dark:peer-focus:text-primary"></label></div>  <div class="text-center" data-svelte-h="svelte-13w16j7"><button type="submit" class="inline-block w-5/6 rounded bg-blue-400 px-7 pb-2.5 pt-3 uppercase leading-normal text-white shadow-[0_4px_9px_-4px_#3b71ca] transition duration-150 ease-in-out hover:bg-blue-700 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-blue-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-blue-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]" data-te-ripple-init data-te-ripple-color="light">Submit</button></div> ${escape($userName)}</form></section> <section><h2>Hello ${escape($userName)}</h2></section> <section data-markdown>  <div data-template>${escape(`
				- Just some text to try tings out
				[Reveal.js](https://revealjs.com) + [Markdown](https://daringfireball.net/projects/markdown/) = <span class="heart">&#x2764;</span>
				## Slide 1 - generated from MarkDown
				A paragraph with some text and a [link](https://hakim.se).
				---
				## Slide 2 - generated from MarkDown
				- List item 1
				- List item 2
				---
				## Slide 3 - generated from MarkDown
				[x] Task 1
				[ ] Task 2
				[ ] Task 3
				`)}</div></section> <section>${each(Object.keys(sections), (section) => {
    return `<section><h2>${escape(section)}</h2> <p>${escape(sections[section])}</p> </section>`;
  })}</section></div></div>`;
});
export {
  Page as default
};
