'use strict';
// Navegação acessível e formulário de produção Xaraiés.
const improved=document.querySelector('.improved-header');
if(improved){
 const nav=document.querySelector('#main-nav');
 const button=document.querySelector('.menu-toggle');
 const small=matchMedia('(max-width:900px)');
 const nativePopover='showPopover' in HTMLElement.prototype;
 function setup(){
  if(small.matches&&nativePopover){nav.setAttribute('popover','auto');button.setAttribute('popovertarget','main-nav');}
  else{nav.removeAttribute('popover');button.removeAttribute('popovertarget');}
  nav.classList.remove('fallback-open');button.setAttribute('aria-expanded','false');
 }
 function close(){
  if(nativePopover&&nav.matches(':popover-open'))nav.hidePopover();
  nav.classList.remove('fallback-open');button.setAttribute('aria-expanded','false');
 }
 nav.addEventListener('toggle',e=>button.setAttribute('aria-expanded',String(e.newState==='open')));
 if(!nativePopover){
  button.addEventListener('click',()=>{const open=nav.classList.toggle('fallback-open');button.setAttribute('aria-expanded',String(open));});
  document.addEventListener('keydown',e=>{if(e.key==='Escape'&&nav.classList.contains('fallback-open')){close();button.focus();}});
  document.addEventListener('click',e=>{if(!improved.contains(e.target))close();});
 }
 nav.querySelectorAll('a').forEach(a=>a.addEventListener('click',close));
 small.addEventListener('change',setup);setup();
 document.querySelectorAll('input,select').forEach(field=>{
  const label=field.closest('label');field.id='trip-'+field.name;label.htmlFor=field.id;
  field.addEventListener('invalid',e=>{
   e.preventDefault();field.setAttribute('aria-invalid','true');
   let error=label.querySelector('.field-error');
   if(!error){error=document.createElement('span');error.className='field-error';error.id=field.id+'-error';error.setAttribute('role','status');label.append(error);}
   error.textContent=field.tagName==='SELECT'?'Selecione uma opção.':'Informe quando pretende viajar.';
   field.setAttribute('aria-describedby',error.id);
   document.querySelector('[aria-invalid="true"]')?.focus();
  });
  field.addEventListener('input',()=>{if(field.validity.valid){field.removeAttribute('aria-invalid');field.removeAttribute('aria-describedby');label.querySelector('.field-error')?.remove();}});
 });
}

document.querySelector('form')?.addEventListener('submit',event=>{
 event.preventDefault();
 const data=new FormData(event.currentTarget);
 const message=`Olá, quero planejar uma viagem na Xaraiés.

Período: ${data.get('period')}
Pessoas: ${data.get('guests')}
Interesse: ${data.get('interest')}`;
 window.open('https://wa.me/5517991431685?text='+encodeURIComponent(message),'_blank','noopener,noreferrer');
 let note=event.currentTarget.querySelector('.form-note');
 if(!note){note=document.createElement('p');note.className='form-note';note.setAttribute('role','status');event.currentTarget.append(note);}
 note.textContent='Abrimos o WhatsApp com seu pedido preenchido.';
});
