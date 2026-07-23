(function(){
  const btn=document.querySelector('.nav-toggle');
  const menu=document.querySelector('#nav-menu');
  if(btn && menu){
    btn.addEventListener('click',()=>{
      const open=menu.classList.toggle('open');
      btn.setAttribute('aria-expanded',String(open));
    });
    menu.querySelectorAll('a').forEach(a=>a.addEventListener('click',()=>{
      if(menu.classList.contains('open')){menu.classList.remove('open');btn.setAttribute('aria-expanded','false');}
    }));
  }
  const y=document.querySelector('#year'); if(y) y.textContent=new Date().getFullYear();
})();