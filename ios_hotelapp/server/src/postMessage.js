/**
 * Send a message via window.webkit.messageHandlers[name].postMessage, or
 * log to the console for debugging.
 *
 * @param  {string} name
 * @param  {any} data - JSONifyable message body
 */
export default function postMessage(name, data) {
    console.info("postMessage", name, data);

    if (!window.webkit) return;
    if (!window.webkit.messageHandlers[name]) {
        console.warn("No handler registered for", name);
        return;
    }
    window.webkit.messageHandlers[name].postMessage(data);
}
