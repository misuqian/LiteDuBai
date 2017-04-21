
// Wait for the DOM to load before dispatching a message to the app extension's Swift code.
document.addEventListener("DOMContentLoaded", function(event) {
    safari.extension.dispatchMessage("GetAdsHide");
});

// Listens for messages sent from the app extension's Swift code.
safari.self.addEventListener("message", messageHandler);

document.addEventListener("DOMSubtreeModified", modifyHandler);

function messageHandler(event){
    console.log("messa:"+event.name);
    if (event.name === "adsHide") {
        if(window.location.hostname.indexOf("www.baidu.com") != -1){
            removeSearchADs(true);
        }
    }else if(event.name === "fileDownload"){
        if(window.location.hostname.indexOf("yun.baidu.com") != -1){
            baiduCloudDownload();
        }
    }
}

function modifyHandler(event){
    if(typeof(event) != "undefined"  && event.target.tagName === "BODY"){
//        console.log("event:"+event)
        safari.extension.dispatchMessage("GetAdsHide");
    }
}

//https://github.com/cloudroc/baidu-nolimit/blob/master/core.js
function baiduCloudDownload(){
    console.log("LiteDuBai:baiduCloudDownload");
    var code = "Object.defineProperty(navigator,'platform',{get:function(){return '';}});";
    var s = document.createElement('script');
    s.textContent = code;
    document.documentElement.appendChild(s);
    s.remove();
}

//删除搜索页顶部的推广
function removeSearchADs(hideRight){
    console.log("LiteDuBai:removeSearchADs");
    var container = document.getElementById('container');
    if(container != null){
        if(hideRight){
            var content_right = findChildDiv(container,'content_right');
            if(content_right!=null){
                var removed = container.removeChild(content_right);
                removed = null;
                console.log("remove:content_right");
            }
        }
        var content_left = findChildDiv(container,'content_left');
        if(content_left != null){
            var leftchilds = content_left.children;
            var reg = new RegExp("\d+", "gi");
            //强制转换成数组
            leftchilds = Array.prototype.slice.call(leftchilds);
            for(var i=leftchilds.length-1;i>0;i--){
                var child = leftchilds[i];
                //console.log("check:"+child.id+","+child.className);
                if(child.tagName.toLowerCase() === 'div'){
                    if(reg.test(child.id) && child.className.indexOf("result") == -1){
                        console.log("remove:"+child.id+","+child.className);
                        child.style.display = "none";
                        var removed = content_left.removeChild(child);
                        removed = null;
                    }else if(checkChildNodes(child,reg) && child.className.indexOf("result") == -1){
                        console.log("remove:"+child.id+","+child.className);
                        child.style.display = "none";
                        var removed = content_left.removeChild(child);
                        removed = null;
                    }else if(child.style.display === 'block' && child.className.indexOf("result") == -1){
                        console.log("remove:"+child.id+","+child.className);
                        child.style.display = "none";
                        var removed = content_left.removeChild(child);
                        removed = null;
                    }
                }
            }
        }
    }
}

function findChildDiv(node,id){
    if(node.tagName.toLowerCase() !== 'div'){
        return null;
    }
    // console.log("id:"+(node.id));
    // console.log("length:"+(node.children.length));
    for(var i=0;i<node.children.length;i++){
        var child = node.children[i];
        // console.log("childNodes:"+(child.tagName)+","+i);
        if(child != null && child.tagName.toLowerCase() === 'div' && child.id === id){
            return child;
        }
    }
    return null;
}

function checkChildNodes(node,reg){
    var childs = node.children;
    for(var i=0;i<childs.length;i++){
        if(reg.test(childs[i].id) && childs[i].className.indexOf("result") == -1){
            return true;
        }
    }
    return false;
}
