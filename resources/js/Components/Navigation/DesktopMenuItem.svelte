<script>
    import {inertia} from "@inertiajs/svelte";
    import {page} from '@inertiajs/svelte';

    export let title;
    export let url;
    export let exactMatch = true;
</script>

<a href={url}
   use:inertia
   class={['w-full text-left px-3 py-2 rounded-md text-sm font-medium hover:bg-gray-700',
   exactMatch ? ($page.url === url ? 'bg-gray-700 text-white' : 'text-gray-300') : '',
   !exactMatch ? ($page.url.startsWith(url) ? 'bg-gray-700 text-white' : 'text-gray-300') : '',
   $$restProps.class].join(' ').trim()}
   aria-current="page">
    {title}
</a>
