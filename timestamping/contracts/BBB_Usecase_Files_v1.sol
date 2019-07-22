pragma solidity >=0.5.0 <0.6.0;

/* MIT Licence:

Copyright (c) 2018-2019 TU Berlin, DSI https://www.dsi.tu-berlin.de

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import "./BBB_Usecase.sol";
import "./StringUtils.sol";

contract BBB_Usecase_Files_v1 is BBB_Usecase {
    string public rssUrl;

    File[] public files;
    uint256 public filesSize;

    constructor(address payable _dsi, address payable _urd, address _crawler, string memory _rssUrl, bool _active) BBB_Usecase(_dsi, _urd, _active) public {
        rssUrl = _rssUrl;
        setCrawler(_crawler);
    }

    function getType() public pure returns (uint) {
        return 1;
    }

    // Structs
    struct File {
        string guid;
        string author;
        string url;
        string hash;
        uint time;
    }

    // Events
    event NewFile(
        uint indexed index
    );

    // Getter / Setter
    function getFileUrl(uint _i) public view returns (string memory) { return files[_i].url; }
    function getFileTime(uint _i) public view returns (uint) { return files[_i].time; }
    function getFileHash(uint _i) public view returns (string memory) { return files[_i].hash; }
    function getFileGuid(uint _i) public view returns (string memory) { return files[_i].guid; }
    function getFileAuthor(uint _i) public view returns (string memory) { return files[_i].author; }

    // New File
   function newFile(string memory _guid, string memory _author, string memory _url, string memory _hash) public  {
       /* assert(filesSize < 2**256 - 1);

        // Check for uniqueness
        for(uint i = 0; i < filesSize; i++) {
            if(StringUtils.equal(files[i].guid, _guid)) {
                // STOP because file is already saved
                revert();
            }
        }*/

        File memory file = File(_guid, _author, _url, _hash, now);
        files.push(file);

        emit NewFile(filesSize);

        filesSize++;
    }
}