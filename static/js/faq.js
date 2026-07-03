document.addEventListener('DOMContentLoaded', ()=>{
  document.querySelectorAll('.faq-item .faq-q').forEach(btn=>{
    btn.addEventListener('click', ()=>{
      const item = btn.closest('.faq-item');
      const wasOpen = item.classList.contains('open');
      document.querySelectorAll('.faq-item.open').forEach(i=> i.classList.remove('open'));
      if(!wasOpen) item.classList.add('open');
    });
  });
});