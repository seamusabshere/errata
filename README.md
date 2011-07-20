# errata

Correct strings based on remote errata files.

# Example

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

## Real-life usage

Used by [data_miner](http://github.com/seamusabshere/data_miner)

## Authors

* Seamus Abshere <seamus@abshere.net>
* Andy Rossmeissl <andy@rossmeissl.net>

## Copyright

Copyright (c) 2011 Brighter Planet. See LICENSE for details.
