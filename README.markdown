# errata

Define an errata in table format (CSV) and then apply it to an arbitrary source. Inspired by RFC Errata, lets you keep your own errata in a transparent way.

Tested in MRI 1.8.7+, MRI 1.9.2+, and JRuby 1.6.7+. Thread safe.

## Inspiration

There's a process for reporting errata on RFC:

* [RFC Errata](http://www.rfc-editor.org/errata.php)
* [Status and Type Descriptions for RFC Errata](http://www.rfc-editor.org/status_type_desc.html)
* [How to report errata](http://www.rfc-editor.org/how_to_report.html)

<p><a href="http://www.rfc-editor.org"><img src="https://github.com/seamusabshere/errata/raw/master/rfc_editor.png" alt="screenshot of the RFC Editor" /></a></p>

## Example

Every errata has a table structure based on the [IETF RFC Editor's "How to Report Errata"](http://www.rfc-editor.org/how_to_report.html).

<table>
  <tr>
    <th>date</th>
    <th>name</th>
    <th>email</th>
    <th>type</th>
    <th>section</th>
    <th>action</th>
    <th>x</th>
    <th>y</th>
    <th>condition</th>
    <th>notes</th>
  </tr>
  <tr>
    <td>2011-03-22</td>
    <td>Ian Hough</td>
    <td>ian@brighterplanet.com</td>
    <td>meta</td>
    <td>Intended use</td>
    <td></td>
    <td>http://example.com/original-data-with-errors.xls</td>
    <td></td>
    <td></td>
    <td>A hypothetical document that uses non-ISO country names</td>
  </tr>
  <tr>
    <td>2011-03-22</td>
    <td>Ian Hough</td>
    <td>ian@brighterplanet.com</td>
    <td>technical</td>
    <td>Country Name</td>
    <td>replace</td>
    <td>/ANTIGUA &amp; BARBUDA/</td>
    <td>ANTIGUA AND BARBUDA</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>2011-03-22</td>
    <td>Ian Hough</td>
    <td>ian@brighterplanet.com</td>
    <td>technical</td>
    <td>Country Name</td>
    <td>replace</td>
    <td>/BOLIVIA/</td>
    <td>BOLIVIA, PLURINATIONAL STATE OF</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>2011-03-22</td>
    <td>Ian Hough</td>
    <td>ian@brighterplanet.com</td>
    <td>technical</td>
    <td>Country Name</td>
    <td>replace</td>
    <td>/BOSNIA &amp; HERZEGOVINA/</td>
    <td>BOSNIA AND HERZEGOVINA</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>2011-03-22</td>
    <td>Ian Hough</td>
    <td>ian@brighterplanet.com</td>
    <td>technical</td>
    <td>Country Name</td>
    <td>replace</td>
    <td>/BRITISH VIRGIN ISLANDS/</td>
    <td>VIRGIN ISLANDS, BRITISH</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>2011-03-22</td>
    <td>Ian Hough</td>
    <td>ian@brighterplanet.com</td>
    <td>technical</td>
    <td>Country Name</td>
    <td>replace</td>
    <td>/COTE D'IVOIRE/</td>
    <td>CÔTE D'IVOIRE</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>2011-03-22</td>
    <td>Ian Hough</td>
    <td>ian@brighterplanet.com</td>
    <td>technical</td>
    <td>Country Name</td>
    <td>replace</td>
    <td>/DEM\. PEOPLE'S REP\. OF KOREA/</td>
    <td>KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>2011-03-22</td>
    <td>Ian Hough</td>
    <td>ian@brighterplanet.com</td>
    <td>technical</td>
    <td>Country Name</td>
    <td>replace</td>
    <td>/DEM\. REP\. OF THE CONGO/</td>
    <td>CONGO, THE DEMOCRATIC REPUBLIC OF THE</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>2011-03-22</td>
    <td>Ian Hough</td>
    <td>ian@brighterplanet.com</td>
    <td>technical</td>
    <td>Country Name</td>
    <td>replace</td>
    <td>/HONG KONG SAR/</td>
    <td>HONG KONG</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>2011-03-22</td>
    <td>Ian Hough</td>
    <td>ian@brighterplanet.com</td>
    <td>technical</td>
    <td>Country Name</td>
    <td>replace</td>
    <td>/IRAN \(ISLAMIC REPUBLIC OF\)/</td>
    <td>IRAN, ISLAMIC REPUBLIC OF</td>
    <td></td>
    <td></td>
  </tr>
</table>

Which would be saved as a CSV:

    date,name,email,type,section,action,x,y,condition,notes
    2011-03-22,Ian Hough,ian@brighterplanet.com,meta,Intended use,,http://example.com/original-data-with-errors.xls,,A hypothetical document that uses non-ISO country names
    2011-03-22,Ian Hough,ian@brighterplanet.com,technical,Country Name,replace,/ANTIGUA & BARBUDA/,ANTIGUA AND BARBUDA,,
    2011-03-22,Ian Hough,ian@brighterplanet.com,technical,Country Name,replace,/BOLIVIA/,"BOLIVIA, PLURINATIONAL STATE OF",,
    2011-03-22,Ian Hough,ian@brighterplanet.com,technical,Country Name,replace,/BOSNIA & HERZEGOVINA/,BOSNIA AND HERZEGOVINA,,
    2011-03-22,Ian Hough,ian@brighterplanet.com,technical,Country Name,replace,/BRITISH VIRGIN ISLANDS/,"VIRGIN ISLANDS, BRITISH",,
    2011-03-22,Ian Hough,ian@brighterplanet.com,technical,Country Name,replace,/COTE D'IVOIRE/,CÔTE D'IVOIRE,,
    2011-03-22,Ian Hough,ian@brighterplanet.com,technical,Country Name,replace,/DEM\.  PEOPLE'S REP\. OF KOREA/,"KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF",,
    2011-03-22,Ian Hough,ian@brighterplanet.com,technical,Country Name,replace,/DEM\. REP\. OF THE CONGO/,"CONGO, THE DEMOCRATIC REPUBLIC OF THE",,
    2011-03-22,Ian Hough,ian@brighterplanet.com,technical,Country Name,replace,/HONG KONG SAR/,HONG KONG,,
    2011-03-22,Ian Hough,ian@brighterplanet.com,technical,Country Name,replace,/IRAN \(ISLAMIC REPUBLIC OF\)/,"IRAN, ISLAMIC REPUBLIC OF",,

And then used

    errata = Errata.new(:url => 'http://example.com/errata.csv')
    original = RemoteTable.new(:url => 'http://example.com/original-data-with-errors.xls')
    original.each do |row|
      errata.correct! row # destructively correct each row
    end

## UTF-8

Assumes all input strings are UTF-8. Otherwise there can be problems with Ruby 1.9 and Regexp::FIXEDENCODING. Specifically, ASCII-8BIT regexps might be applied to UTF-8 strings (or vice-versa), resulting in Encoding::CompatibilityError.

## More advanced usage

The [`earth` library](https://github.com/brighterplanet/earth) has dozens of real-life examples showing errata in action:

<table>
  <tr>
    <th>Model</th>
    <th>Reference</th>
    <th>Errata file</th>
  </tr>
  <tr>
    <td><a href="http://data.brighterplanet.com/countries">Country</a></td>
    <td><a href="https://github.com/brighterplanet/earth/blob/master/lib/earth/locality/country/data_miner.rb">data_miner.rb</a></td>
    <td><a href="https://raw.github.com/brighterplanet/earth/master/errata/country/wri_errata.csv">wri_errata.csv</a></td>
  </tr>
  <tr>
    <td><a href="http://data.brighterplanet.com/aircraft">Aircraft</a></td>
    <td><a href="https://github.com/brighterplanet/earth/blob/master/lib/earth/air/aircraft/data_miner.rb">data_miner.rb</a></td>
    <td><a href="https://raw.github.com/brighterplanet/earth/master/errata/aircraft/faa_errata.csv">faa_errata.csv</a></td>
  </tr>
  <tr>
    <td><a href="http://data.brighterplanet.com/airports">Airports</a></td>
    <td><a href="https://github.com/brighterplanet/earth/blob/master/lib/earth/air/airport/data_miner.rb">data_miner.rb</a></td>
    <td><a href="https://raw.github.com/brighterplanet/earth/master/errata/airport/openflights_errata.csv">openflights_errata.csv</a></td>
  </tr>
  <tr>
    <td><a href="http://data.brighterplanet.com/automobile_make_model_year_variants">Automobile model variants</a></td>
    <td><a href="https://github.com/brighterplanet/earth/blob/master/lib/earth/automobile/automobile_make_model_year_variant/data_miner.rb">data_miner.rb</a></td>
    <td><a href="https://raw.github.com/brighterplanet/earth/master/errata/automobile_make_model_year_variant/feg_errata.csv">feg_errata.csv</a></td>
  </tr>
</table>

## Real-world usage

<p><a href="http://brighterplanet.com"><img src="https://s3.amazonaws.com/static.brighterplanet.com/assets/logos/flush-left/inline/green/rasterized/brighter_planet-160-transparent.png" alt="Brighter Planet logo"/></a></p>

We use `errata` for [data science at Brighter Planet](http://brighterplanet.com/research) and in production at

* [Brighter Planet's reference data web service](http://data.brighterplanet.com)
* [Brighter Planet's impact estimate web service](http://impact.brighterplanet.com)

The killer combination:

1. [`active_record_inline_schema`](https://github.com/seamusabshere/active_record_inline_schema) - define table structure
2. [`remote_table`](https://github.com/seamusabshere/remote_table) - download data and parse it
3. [`errata`](https://github.com/seamusabshere/errata) (this library!) - apply corrections in a transparent way
4. [`data_miner`](https://github.com/seamusabshere/remote_table) - import data idempotently

## Authors

* Seamus Abshere <seamus@abshere.net>
* Andy Rossmeissl <andy@rossmeissl.net>
* Ian Hough <ijhough@gmail.com>

## Copyright

Copyright (c) 2012 Brighter Planet. See LICENSE for details.
