<script lang="ts">
	import { onMount } from 'svelte';
	import 'reveal.js/dist/reveal.css';
	import 'reveal.js/dist/theme/black.css';
	// // import Markdown from 'reveal.js/plugin/markdown/markdown'
	import Reveal from 'reveal.js'
	// // // import Highlight from 'reveal.js/plugin/highlight/highlight'
	import Markdown from 'reveal.js/plugin/markdown/markdown'
	// // // import Notes from 'reveal.js/plugin/notes/notes'
	// // // import 'reveal.js/dist/theme/black.css';
	// import 'tw-elements/dist/tw-elements.css';
	// import { Input, Ripple, initTE } from 'tw-elements/dist/tw-elements.js';
	import { Input, Ripple, initTWE } from 'tw-elements';
	export let partner = ['Svelte', 'RevealJS', 'Tailwind'];
	onMount(async () => {
		const slides = new Reveal({
			plugins: [Markdown],
			// autoAnimateEasing: 'ease',
			// autoAnimateDuration: 1,
			// hash: true
			// controls: false,
			// progress: false
		})
		slides.initialize();
		const deck = new Reveal({
			plugins: [Markdown],
		});
		deck.initialize({ embedded: true });
		
		// const Reveal = (await import('reveal.js')).default;
		// Reveal.initialize({
		// 	plugins: [Markdown],
		// });

		// initTE(
		// 	{ Input: Input, Ripple: Ripple },
		// 	{ allowReinits: true, checkOtherImports: true }
		// );

		// const te = await import('tw-elements');
		// te.initTE(
		// 	{ Input: te.Input, Ripple: te.Ripple },
		// 	{ allowReinits: true, checkOtherImports: true }
		// );
		initTWE(
			{ Input, Ripple },
			{ allowReinits: true, checkOtherImports: true }
		);
	});
	import { userName } from '$lib/stores';

	const saveNameToStore = (event: Event) => {
		event.preventDefault();
		const name = (event.target as HTMLFormElement).name.value;
		console.log(name);
		userName.set(name);
	};

	const sections = {
		"Title 1": "paragraph",
		"Title 2": "paragraph",
		"Title 3": "paragraph",
		"Title 4": "paragraph",
		"Title 5": "paragraph"
	}
</script>

<div class="reveal">
	<div class="slides">
		<section>
			<h2>{partner.join(' + ')} = <span class="heart">&#x2764</span></h2>
			<p class="text-pink-300">Lets have fun!</p>
		</section>
		<section>
			<h2>Slide 2</h2>
		</section>
		<section>
			<h2>User input</h2>
			<form method="POST" on:submit|preventDefault={saveNameToStore}>
				<div class="relative mb-6" data-twe-input-wrapper-init>
					<input
						type="text"
						class="peer block min-h-[auto] w-full rounded border-0 bg-transparent px-3 py-[0.32rem] leading-[1.6] outline-none transition-all duration-200 ease-linear focus:placeholder:opacity-100 peer-focus:text-primary data-[twe-input-state-active]:placeholder:opacity-100 motion-reduce:transition-none dark:text-white dark:placeholder:text-neutral-300 dark:autofill:shadow-autofill dark:peer-focus:text-primary [&:not([data-twe-input-placeholder-active])]:placeholder:opacity-0"
						id="nameField"
						name="name"
						placeholder="Full name"
					/>
					<label
						for="nameField"
						class="pointer-events-none absolute left-3 top-0 mb-0 max-w-[90%] origin-[0_0] truncate pt-[0.37rem] leading-[1.6] text-neutral-500 transition-all duration-200 ease-out peer-focus:-translate-y-[0.9rem] peer-focus:scale-[0.8] peer-focus:text-primary peer-data-[twe-input-state-active]:-translate-y-[0.9rem] peer-data-[twe-input-state-active]:scale-[0.8] motion-reduce:transition-none dark:text-neutral-400 dark:peer-focus:text-primary"
						>Name
					</label>
				</div>

				<!-- Submit button -->
				<div class="text-center">
					<button
						type="submit"
						class="inline-block w-5/6 rounded bg-blue-400 px-7 pb-2.5 pt-3 uppercase leading-normal text-white shadow-[0_4px_9px_-4px_#3b71ca] transition duration-150 ease-in-out hover:bg-blue-700 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-blue-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-blue-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]"
						data-te-ripple-init
						data-te-ripple-color="light"
					>
						Submit
					</button>
				</div>
				{$userName}
			</form>
		</section>
		<section>
			<h2>Hello {$userName}</h2>
		</section>
		<section data-markdown>
			<!-- <script type="text/template">
				{`
				## Slide 1
				A paragraph with some text and a [link](https://hakim.se).
				---
				## Slide 2
				---
				## Slide 3
				`}
			</script> -->
			<!-- <textarea data-template>
				{`
				- Just some text to try tings out
				[Reveal.js](https://revealjs.com) + [Markdown](https://daringfireball.net/projects/markdown/) = <span class="heart">&#x2764;</span>
				## Slide 1
				A paragraph with some text and a [link](https://hakim.se).
				---
				## Slide 2
				---
				## Slide 3
				`}
			</textarea> -->
			<div data-template>
				{`
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
				- [x] Task 1
				- [ ] Task 2
				- [ ] Task 3
				`}
			</div>
		</section>
		<section>
			{#each Object.keys(sections) as section}
				<section>
					<h2>{section}</h2>
					<p>{sections[section]}</p>
				</section>
			{/each}
		</section>
	</div>
</div>
