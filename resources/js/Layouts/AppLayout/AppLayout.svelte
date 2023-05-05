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
                <DesktopMenuItem title="Groups" url="/groups" />
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
