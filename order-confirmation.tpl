{*
* 2007-2014 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2014 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
{literal}
<script type="text/javascript">
window.dataLayer = window.dataLayer || [];
dataLayer.push({
  'transactionId': '{/literal}{$id_pedido}{literal}',        
  'transactionTotal': {/literal}{$total_a_pagar}{literal},
  'paymentType': {/literal}'{$orderPaymentType}'{literal},
  'transactionNames': '{/literal}{$productNames}{literal}',
  'transactionRates': '{/literal}{$puntuaciones}{literal}',
  'transactionTax': {/literal}{$impuestos}{literal},
  'transactionShipping': {/literal}{$gastos_envio}{literal},
  'transactionReference': '{/literal}{$reference}{literal}',
  'transactionProducts': [{/literal}{foreach from=$productos item=producto name=productos}{literal}
  {				
		'sku': '{/literal}{$producto.reference}{literal}',
		'category': '{/literal}{$producto.category}{literal}',
		'name': '{/literal}{$producto.name}{literal}',
		'price': {/literal}{$producto.price_wt}{literal},		
		'quantity': {/literal}{$producto.quantity}{literal}
   }{/literal}{if $smarty.foreach.productos.iteration != $productos|@count}{literal},{/literal}{/if}{literal}
	{/literal}{/foreach}],{literal}
   'event': 'transactionComplete'
}
) 
</script>
{/literal}
{capture name=path}{l s='Order confirmation'}{/capture}

<h1 class="page-heading">{l s='Order confirmation'}</h1>

{assign var='current_step' value='payment'}
{include file="$tpl_dir./order-steps.tpl"}

{include file="$tpl_dir./errors.tpl"}

{$HOOK_ORDER_CONFIRMATION}
{$HOOK_PAYMENT_RETURN}

{if $is_guest}
	<p>{l s='Your order ID is:'} <span class="bold">{$id_order_formatted}</span> . {l s='Your order ID has been sent via email.'}</p>
    <p class="cart_navigation exclusive">
	<a class="button-exclusive btn btn-default" href="{$link->getPageLink('guest-tracking', true, NULL, "id_order={$reference_order|urlencode}&email={$email|urlencode}")|escape:'html':'UTF-8'}" title="{l s='Follow my order'}">{l s='Follow my order'}</a>
    </p>
{else}
	<p>{l s='Ha seleccionado al'}<b> {l s='banco Sabadell'}</b> {l s='como forma de pago.'}</p>
	<p><span class="paypal-bold">{l s='Le enviaremos el pedido lo antes posible.' mod='paypal'}</span></p>
	<p>{l s='Si tiene dudas o necesita información adicional, póngase en contacto con nuestro' mod='paypal'}
	<a href="{$link->getPageLink('contact', true)|escape:'htmlall':'UTF-8'}" data-ajax="false" target="_blank">{l s='servicio de atención al cliente.' mod='paypal'}</a><b> {l s='(931 716 828)'}</b>
	</p>

	</br>
	
	<a class="btn btn-success" href="{$link->getPageLink('history.php', true)|escape:'htmlall':'UTF-8'}" title="{l s='Back to orders' mod='paypal'}" data-ajax="false">{l s='Ir a mis pedidos' mod='paypal'}</a>

{/if}
