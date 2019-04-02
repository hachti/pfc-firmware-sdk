/*
 * Copyright (c) 2018 WAGO Kontakttechnik GmbH & Co. KG
 *
 * PROPRIETARY RIGHTS are involved in the subject matter of this material.
 */

var SecurityContent = function(id)
{
  var securityContent = this;

  securityContent.id = id || 'security';

  //------------------------------------------------------------------------------
  // internal functions
  //------------------------------------------------------------------------------


  //------------------------------------------------------------------------------
  // initialize view elements
  //------------------------------------------------------------------------------
  var SecurityParamView = (function()
  {
    securityContent.paramView = new DeviceParamView();

    securityContent.paramView.Add(
    {
      paramId         : 'tls_cipher_list_class',
      //outputElementId : securityContent.id + '_content #tls_version'
    });

  })();


  //------------------------------------------------------------------------------
  // first creation of area
  //------------------------------------------------------------------------------
  $('#content_area').bind(securityContent.id + '_create', function(event)
  {
    // add events for form processing
    $('#' + securityContent.id + '_content #tls_config_form').bind('submit', function(event)
    {
      event.preventDefault();
      var newCipherListClass =   $('input[name=tls-cipher-list-class]:checked').val();
      securityContent.ChangetlsCipherListClass(newCipherListClass);
    });

  });


  //------------------------------------------------------------------------------
  // refresh of area
  //------------------------------------------------------------------------------
  $('#content_area').bind(securityContent.id + '_refresh', function(event)
  {
    securityContent.Refresh();
  });

};


SecurityContent.prototype.Refresh = function()
{
  var securityContent = this;

  deviceParams.ReadValueGroup(securityContent.paramView.list, function()
  {
    //securityContent.paramView.ShowValues();
    if(deviceParams.ReadErrorOccured(securityContent.paramView.list))
    {
      var errorString = deviceParams.CollectedErrorStrings(securityContent.paramView.list);
      $('body').trigger('event_errorOccured', [ 'Error while reading security configuration.', errorString ] );
    }
    else
    {
      //var tlsVersion = deviceParams.list['tls_cipher_list_class'].value;
      switch(deviceParams.list['tls_cipher_list_class'].value)
      {
        case 'standard':  $("input[name=tls-cipher-list-class][value=standard]").prop("checked", "checked"); break;
        case 'strong':    $("input[name=tls-cipher-list-class][value=strong]").prop("checked", "checked"); break;
        default:          break;
      }
    }
  });

};

SecurityContent.prototype.ChangetlsCipherListClass = function(newCipherListClass)
{
  var securityContent = this;
  var newValueList;

  if(newCipherListClass === 'standard')
  {
    newValueList = { cipherListClass: 'standard' };
  }
  else
  {
    newValueList = { cipherListClass: 'strong' };
  }

  pageElements.ShowBusyScreen('Changing TLS version...');


  deviceParams.ChangeValue('tls_cipher_list_class', newValueList, function(status, errorText)
  {
    if(SUCCESS != status)
    {
      pageElements.RemoveBusyScreen();
      $('body').trigger('event_errorOccured', [ 'Error while changing TLS version.', errorText ]);
    } else {
      // after a successfull change, a restart of the webserver is required for the changes to take effect
      // then initiate restart of webserver
      deviceParams.ChangeValue('restart_webserver', { }, function(status, errorText)
      {
        // webserver restart will always return with an error -
        //  do nothing, but hide the busy-box and re-read the values
        
        // wait about 1 second (reading takes about that amount of time)
        setTimeout(function() {
          // show current configuration
          securityContent.Refresh();
          pageElements.RemoveBusyScreen();
        }, 1000);

      });
    }
  });
};
