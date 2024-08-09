document.addEventListener('turbo:load', () => {
  const deleteLinks = document.querySelectorAll('a[data-method="delete"]');

  deleteLinks.forEach(link => {
    link.addEventListener('ajax:success', event => {
      const target = event.target.closest('.comment');
      target.remove();
    });

    link.addEventListener('ajax:error', () => {
      alert('コメントを削除できませんでした。もう一度お試しください。');
    });
  });
});