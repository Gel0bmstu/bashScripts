javascript: links_wrapper = document.querySelector('[ng-show="build_list.packages"]');link_list = links_wrapper.querySelectorAll('[ng-href]');block_title = links_wrapper.getElementsByTagName('h3')[0];href_list = [];link_list.forEach((h) => {    if ((h.text.match(/.rpm$/i)) && !(h.text.match(/src.rpm$/i))) { href_list.push('wget -q -O', h.text, h.href, '&');  };});href_list.push('wait');setTimeout(async () => {    await window.navigator.clipboard.writeText(href_list.join(' '))    .then(() => {block_title.textContent = 'Packages | All ' + (href_list.length - 1) / 4 + ' download links are copied to clipboard.'; console.log('ok')})    .catch(() => {block_title.textContent = 'Packages | Please, focus on page after running script.'; console.error('Focus!')}) }, 0);
