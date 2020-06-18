using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Healthbar : MonoBehaviour
{
    [SerializeField] private RectTransform _fill;
    private Vector3 _emptyPos;
    private Vector3 _fullPos;

    private void Start()
    {
        //le 0.15 a enlever apres nouvelles assets
        _emptyPos = transform.position - new Vector3(_fill.rect.width*0.15f, 0, 0);
        _fullPos = transform.position;
    }

    public void UpdateBar(int health, int maxHealth)
    {
        float perc = (float)health/(float)maxHealth;
        _fill.transform.position = Vector3.Lerp(_emptyPos, _fullPos, perc);

    }
}
