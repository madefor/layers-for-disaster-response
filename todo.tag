
<todo>

  <h3>{ title } <a href={ url }>{ url }</a></h3>

  <ul>
    <li each={ items.filter(whatShow) }>
      <label class={ completed: done }>
        <input type="checkbox" checked={ done } onclick={ parent.toggle }> { title }
      </label>
    </li>
  </ul>

  <form onsubmit={ add }>
    <input name="input" onkeyup={ edit }>
    <button disabled={ !text }>Add #{ items.filter(whatShow).length + 1 }</button>

    <button disabled={ items.filter(onlyDone).length == 0 } onclick={ removeAllDone }>
    X{ items.filter(onlyDone).length } </button>
  </form>

  <!-- this script tag is optional -->
  <script>
    var items = []
    var title = ''
    var jumpInto = function(array, current) {
      for(i in array) {
        if(array[i].type == 'LayerGroup') {
          jumpInto(array[i].entries, current + '/' + array[i].title)
        } else {
          items.push({title : current + '/' + array[i].title})
        }
      }
    }
    var request = new XMLHttpRequest()
    request.open('GET', opts.url, false)
    request.onload = function() {
      if (request.status >= 200 && request.status < 400) {
        var r = JSON.parse(request.responseText)
        title = r.layers[0].title
        jumpInto(r.layers, '');
      }
    }
    request.send()
    this.url = opts.url;
    this.items = items
    this.title = title

    edit(e) {
      this.text = e.target.value
    }

    add(e) {
      if (this.text) {
        this.items.push({ title: this.text })
        this.text = this.input.value = ''
      }
    }

    removeAllDone(e) {
      this.items = this.items.filter(function(item) {
        return !item.done
      })
    }

    // an two example how to filter items on the list
    whatShow(item) {
      return !item.hidden
    }

    onlyDone(item) {
      return item.done
    }

    toggle(e) {
      var item = e.item
      item.done = !item.done
      return true
    }

    load() {
      console.log('hello');
      var request = new XMLHttpRequest()
      request.open('GET', opts.url, true)
      request.onload = function() {
        if (request.status >= 200 && request.status < 400) {
          var r = JSON.parse(request.responseText)
          console.log(r)
          console.log(e)
        }
      }
      request.send()
    }

  </script>

</todo>
