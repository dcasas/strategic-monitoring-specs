# Strategic Monitoring Domain
This provides a high level description of the [`SM`] domain.
This is the entry point to anyone interested on learning about the [`SM`] domain, so this file should contain any relevant information  that helps anyone to get a good idea what this is about.

`TBC`

<div style="width: 640px; height: 480px; margin: 10px; position: relative;">
    <iframe allowfullscreen="allowfullscreen" 
            frameborder="0" 
            style="width:640px; height:480px" 
            src="https://www.lucidchart.com/documents/embeddedchart/cde32bc7-d9d9-4503-aef2-82b1ecbbfc25" 
            id="fmFcxa0I7jjw">
            it should shown a diagram
    </iframe>
    &nbsp;
</div>

![SM Domain](http://g.gravizo.com/g?
  digraph G {
      ClinicalTrial [shape=box, label="Clinical Trial"]
      ClinicalTrial -> a [color=Grey, style=dotted]
      ClinicalTrial -> b [color=Grey, style=dotted]
      ClinicalTrial -> Monitoring
      ClinicalTrial -> c [color=Grey, style=dotted]
      ClinicalTrial -> d [color=Grey, style=dotted]
      a [color=Grey, style=dotted]
      b [color=Grey, style=dotted]
      c [color=Grey, style=dotted]
      d [color=Grey, style=dotted]
      Monitoring [color=red]
      Monitoring -> Issue
      Monitoring -> Notification
      Monitoring -> Visit
      Monitoring -> etc [color=grey, style=dotted]
      Issue [color=blue]
      Notification [color=green]
      Visit [color=brown]
      etc [color=grey, style=dotted]
  }
)

# Glossary
See [GLOSSARY](GLOSSARY.md)
<!-- GLOSSARY:Index global='true' -->

<!-- /GLOSSARY:Index -->

# Meet the Domain Owners
Each subdomain would have two owners: a technical owner and a business owner. Both owners would be responsible to keep their subdomain specs up-to-date and relevant, making sure the specs are specific enough (so DEVs can directly use them to asses the quality of the system) but detached from implementation details (so we can adapt to technological changes).

| Subdomain                    | Business Owner | Technical Owner                                                              |
|------------------------------|----------------|------------------------------------------------------------------------------|
| Domain X | ![INeedYou] | ![INeedYou] |

[`SM`]: GLOSSARY.md#sm "Strategic Monitoring"
[`Command`]: GLOSSARY.md#command "Command"
[`Query`]: GLOSSARY.md#query "Query"
[INeedYou]: http://www.beavercreek.k12.oh.us/cms/lib5/OH01000456/Centricity/Domain/30/landmarks_symbols/images/uncle_sam1.png "I Need You"
