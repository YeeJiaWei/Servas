<script context="module">
    import { writable } from "svelte/store";

    export const title = writable(null);
    export const showHeader = writable(true);
</script>

<script>
    import { inertia, page } from "@inertiajs/svelte";
    import LinkModal from "@/Partials/LinkModal.svelte";
    import DeleteLinkModal from "@/Partials/DeleteLinkModal.svelte";
    import { route, dispatchCustomEvent } from "@/utils";
    import DesktopMenuItem from "@/Components/Navigation/DesktopMenuItem.svelte";
    import DeleteTagModel from "@/Partials/DeleteTagModel.svelte";
    import CommandPalette from "@/Partials/CommandPalette.svelte";
    import Logo from "@/Components/Icons/Logo.svelte";
    import DeleteGroupModal from "@/Partials/DeleteGroupModal.svelte";

    const appName = $page.props.appName;

    function handleKeydown(event) {
        if (event.key === "f" && event.target.tagName !== "INPUT") {
            if (
                event.metaKey ||
                event.altKey ||
                event.shiftKey ||
                event.ctrlKey
            ) {
                return;
            }

            event.preventDefault();
            event.stopPropagation();

            dispatchCustomEvent("showCommandPalette");
        }
    }
</script>

<svelte:head>
    <title>{$title ? `${$title} | ${appName}` : appName}</title>
</svelte:head>

<svelte:window on:keydown={handleKeydown} />

<div
    class="fixed inset-y-0 flex flex-col justify-between p-2 w-[200px] text-center bg-gray-900"
>
    <div>
        <div class="text-gray-100 text-xl">
            <div class="flex items-center p-2.5 ml-2 mt-1">
                <a
                    href={route("home")}
                    use:inertia
                    on:click={() => (showMobileMenu = false)}
                    class="mr-2.5"
                >
                    <Logo class="h-8 w-8" />
                </a>
                <div class="font-medium text-gray-50">
                    <a
                        href={route("home")}
                        use:inertia
                        on:click={() => (showMobileMenu = false)}>{appName}</a
                    >
                </div>
            </div>
            <div class="my-2 bg-gray-600 h-[1px]" />
        </div>

        <nav class="hidden md:block">
            <div class="flex flex-col items-baseline space-y-2">
                <button
                    on:click={() => dispatchCustomEvent("showCommandPalette")}
                    title="Open search bar"
                    type="button"
                    class="w-full flex justify-between bg-gray-800 py-1 px-2 rounded-full text-gray-300 hover:text-white focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-800 focus:ring-white"
                >
                    <span>Search</span>
                    <!-- Heroicon name: outline/search -->
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="h-6 w-6"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                    >
                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            stroke-width="2"
                            d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                        />
                    </svg>
                </button>

                <DesktopMenuItem
                    title="Links"
                    url="/links"
                    exactMatch={false}
                />
                
                <!-- <DesktopMenuItem title="Groups" url="/groups" /> -->

                <div class="flex items-center">
                    <div class="px-3 py-2 rounded-md text-sm font-medium text-gray-300">Groups</div>
                     <!-- <DesktopMenuItem title="Groups" url="/groups"/> -->

                     
                    <a href='/groups'
                        use:inertia
                        class={['w-full text-left px-3 py-2 rounded-md text-sm font-medium hover:bg-gray-700',
                        $page.url.startsWith('/groups') ? 'bg-gray-700 text-white' : 'text-gray-300',
                        $$restProps.class].join(' ').trim()}
                        aria-current="page">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-4 h-4"><path d="M5.127 3.502L5.25 3.5h9.5c.041 0 .082 0 .123.002A2.251 2.251 0 0012.75 2h-5.5a2.25 2.25 0 00-2.123 1.502zM1 10.25A2.25 2.25 0 013.25 8h13.5A2.25 2.25 0 0119 10.25v5.5A2.25 2.25 0 0116.75 18H3.25A2.25 2.25 0 011 15.75v-5.5zM3.25 6.5c-.04 0-.082 0-.123.002A2.25 2.25 0 015.25 5h9.5c.98 0 1.814.627 2.123 1.502a3.819 3.819 0 00-.123-.002H3.25z"></path></svg>
                    </a>
                    
                    <a href='/grouptree'
                        use:inertia
                        class={['w-full text-left px-3 py-2 rounded-md text-sm font-medium hover:bg-gray-700',
                        $page.url === '/grouptree' ? 'bg-gray-700 text-white' : 'text-gray-300',
                        $$restProps.class].join(' ').trim()}
                        aria-current="page">
                        <svg class="w-4 h-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="none"><path d="M2.25 5C2.94036 5 3.5 4.44036 3.5 3.75C3.5 3.05964 2.94036 2.5 2.25 2.5C1.55964 2.5 1 3.05964 1 3.75C1 4.44036 1.55964 5 2.25 5ZM2.25 9.25C2.94036 9.25 3.5 8.69036 3.5 8C3.5 7.30964 2.94036 6.75 2.25 6.75C1.55964 6.75 1 7.30964 1 8C1 8.69036 1.55964 9.25 2.25 9.25ZM7 12.25C7 12.9404 6.44036 13.5 5.75 13.5C5.05964 13.5 4.5 12.9404 4.5 12.25C4.5 11.5596 5.05964 11 5.75 11C6.44036 11 7 11.5596 7 12.25ZM5.75 3C5.33579 3 5 3.33579 5 3.75C5 4.16421 5.33579 4.5 5.75 4.5H14.25C14.6642 4.5 15 4.16421 15 3.75C15 3.33579 14.6642 3 14.25 3H5.75ZM5 8C5 7.58579 5.33579 7.25 5.75 7.25H14.25C14.6642 7.25 15 7.58579 15 8C15 8.41421 14.6642 8.75 14.25 8.75H5.75C5.33579 8.75 5 8.41421 5 8ZM9.25 11.5C8.83579 11.5 8.5 11.8358 8.5 12.25C8.5 12.6642 8.83579 13 9.25 13H14.25C14.6642 13 15 12.6642 15 12.25C15 11.8358 14.6642 11.5 14.25 11.5H9.25Z" fill="currentColor"></path></svg>
                    </a>
                </div>
                <DesktopMenuItem title="Tags" url="/tags" />
            </div>
        </nav>
    </div>

    <!-- Profile dropdown -->
    <div class="ml-3 relative">
        <a
            href={route("profile.show")}
            use:inertia
            class="block px-4 py-2 text-left text-sm text-gray-200 rounded-md hover:bg-gray-700"
        >
            Profile
        </a>

        <a
            href={route("api-tokens.index")}
            use:inertia
            class="block px-4 py-2 text-left text-sm text-gray-200 rounded-md hover:bg-gray-700"
        >
            API Tokens
        </a>

        <div class="my-2 bg-gray-600 h-[1px]" />

        <div class="flex items-center">
            <div class=" h-8 w-8 rounded-full bg-gray-100 overflow-clip">
                <svg
                    class="h-full w-full text-gray-300"
                    fill="currentColor"
                    viewBox="0 0 24 24"
                >
                    <path
                        d="M24 20.993V24H0v-2.996A14.977 14.977 0 0112.004 15c4.904 0 9.26 2.354 11.996 5.993zM16.002 8.999a4 4 0 11-8 0 4 4 0 018 0z"
                    />
                </svg>
            </div>
            <div class="text-gray-200 text-sm ml-2">
                <div>{$page.props.auth.user.name}</div>
                <!-- <div>{$page.props.auth.user.email}</div> -->
            </div>
        </div>

        <div class="my-2 bg-gray-600 h-[1px]" />

        <button
            use:inertia={{ href: route("logout"), method: "post" }}
            type="button"
            class="block px-4 py-2 w-full text-left text-sm text-gray-200 rounded-md hover:bg-gray-700"
        >
            Log Out
        </button>
    </div>
</div>

<div class="ml-[200px]">
    {#if $showHeader}
        <header class="bg-white shadow">
            <div
                class="flex sm:block justify-between items-center max-w-7xl mx-auto py-3 px-4 sm:px-6  lg:px-8"
            >
                <h1 class="text-xl font-bold text-gray-900">
                    {$title}
                </h1>
                <button
                    on:click={() => dispatchCustomEvent("prepareCreateNewLink")}
                    type="button"
                    class="inline-flex items-center p-1.5 border border-transparent rounded-full shadow-sm text-white bg-primary-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-400 sm:hidden"
                >
                    <svg
                        class="h-5 w-5"
                        xmlns="http://www.w3.org/2000/svg"
                        viewBox="0 0 20 20"
                        fill="currentColor"
                        aria-hidden="true"
                    >
                        <path
                            fill-rule="evenodd"
                            d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                            clip-rule="evenodd"
                        />
                    </svg>
                </button>
            </div>
        </header>
    {/if}

    <main>
        <slot />
    </main>
</div>

<LinkModal />
<DeleteLinkModal />
<DeleteTagModel />
<DeleteGroupModal />
<CommandPalette />
